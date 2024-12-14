import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/profile/data/models/products_statistics_model.dart';
import 'package:online_shopping/Features/profile/data/models/specific_orders_model.dart';
import 'package:online_shopping/Features/profile/domain/repo_interface/profile_repo.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/authentication_services.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';
import 'package:online_shopping/core/utiles/is_same_day.dart';
import 'package:online_shopping/core/utiles/storage_services.dart';

class ProfileRepoImpl extends ProfileRepo {
  ProfileRepoImpl(this.storageServices, this.firestoreServices, this.authServices);

  final StorageServices storageServices;
  final FirestoreServices firestoreServices;
  final AuthServices authServices;
  final UserModel user = UserModel.getInstance();

  @override
  Future<void> updateProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      String newImageURL = await storageServices.uploadFile(imagePicked.path, "/profile_images/${user.uid}/image");
      user.profilePicturePath = newImageURL;

      await firestoreServices.updateField(usersCollectionKey, user.uid, {UserModel.profilePicturePathKey: newImageURL});
    }
  }

  @override
  Future<void> deleteProfileImage() async {
    if (user.profilePicturePath != defaultProfileImage) {
      await storageServices.deleteFile(user.profilePicturePath);

      user.profilePicturePath = defaultProfileImage;
      await firestoreServices.updateField(usersCollectionKey, user.uid, {UserModel.profilePicturePathKey: defaultProfileImage});
    }
  }

  @override
  Future<List<OrderModel>> getMyTodayOrders(DateTime date) async {
    DocumentSnapshot res = await firestoreServices.getDocumentData(usersCollectionKey, user.uid);

    List<OrderModel> orders = [];
    for (Map order in res.get(OrderModel.ordersKey)) {
      OrderModel orderModel = OrderModel.fromJson(order);
      if (isSameDay(orderModel.date, date)) {
        orders.add(orderModel);
      }
    }

    return orders;
  }

  @override
  Future<List<SpecificOrderModel>> getMyOrdersOnSpecificDate(DateTime date) async {
    QuerySnapshot querySnapshot = await firestoreServices.getCollectionData(usersCollectionKey);

    List<SpecificOrderModel> orders = [];

    for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
      for (int i = 0; i < snapshot.get(OrderModel.ordersKey).length; i++) {
        SpecificOrderModel specificOrderModel = SpecificOrderModel.fromJson(snapshot, snapshot.get(OrderModel.ordersKey)[i]);
        if (isSameDay(specificOrderModel.orderModel.date, date)) {
          orders.add(specificOrderModel);
        }
      }
    }

    return orders;
  }

  @override
  Future<void> savePassword(String newPassword) async {
    await authServices.accountDataServices.updatePassword(newPassword);
  }

  @override
  Future<void> saveUserChanges(String name, DateTime dateOfBirth) async {
    UserModel userModel = UserModel(
      name: name,
      uid: user.uid,
      dateOfBirth: dateOfBirth.toIso8601String(),
      email: user.email,
      profilePicturePath: user.profilePicturePath,
      favourites: user.favourites,
      bag: user.bag,
      role: user.role,
    );
    UserModel.setInstance(userModel);
    await firestoreServices.updateField(usersCollectionKey, userModel.uid, userModel.toMap());
  }

  @override
  Future<List<ProductStatisticsModel>> getProductsBestSelling() async {
    QuerySnapshot ordersQuerySnapshot = await firestoreServices.getCollectionData(usersCollectionKey);
    QuerySnapshot productsQuerySnapshot = await firestoreServices.getCollectionData(productsCollectionKey);

    List<String> productsIDs = List<String>.generate(productsQuerySnapshot.docs.length, (int index) {
      return productsQuerySnapshot.docs[index].id;
    });

    Map<String, int> productsQuantities = {};
    for (QueryDocumentSnapshot queryDocumentSnapshot in ordersQuerySnapshot.docs) {
      for (dynamic json in queryDocumentSnapshot.get(OrderModel.ordersKey)) {
        OrderModel order = OrderModel.fromJson(json);
        for (OrderItemModel item in order.items) {
          if (productsIDs.contains(item.productId)) {
            if (productsQuantities.containsKey(item.productId)) {
              productsQuantities[item.productId] = productsQuantities[item.productId]! + item.quantity;
            } else {
              productsQuantities[item.productId] = item.quantity;
            }
          }
        }
      }
    }

    List<MapEntry<String, int>> entries = productsQuantities.entries.toList();
    entries.sort((a, b) => a.value.compareTo(b.value));
    Map<String, int> sortedProductsQuantities = Map.fromEntries(entries);
    List<ProductStatisticsModel> productsStatistics = [];
    int totalQuantity = 0;

    for (int quan in sortedProductsQuantities.values) {
      totalQuantity += quan;
    }

    List<QueryDocumentSnapshot> filteredProductsSnapshot = productsQuerySnapshot.docs.where((doc) => sortedProductsQuantities.containsKey(doc.id)).toList();

    for (QueryDocumentSnapshot json in filteredProductsSnapshot) {
      ProductModel productModel = ProductModel.fromJson(json.data(), json.id);
      double percentage = ((sortedProductsQuantities[productModel.id] ?? 0) / totalQuantity) * 100;
      percentage = double.parse(percentage.toStringAsFixed(2));

      productsStatistics.add(
        ProductStatisticsModel(
          name: productModel.name,
          uid: productModel.id,
          percentage: percentage,
          quantity: sortedProductsQuantities[productModel.id] ?? 0,
        ),
      );
    }

    productsStatistics.sort((a, b) => b.percentage.compareTo(a.percentage));

    return productsStatistics;
  }
}
