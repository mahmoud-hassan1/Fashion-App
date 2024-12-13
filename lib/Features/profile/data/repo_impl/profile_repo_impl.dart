import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/profile/data/models/products_statistics_model.dart';
import 'package:online_shopping/Features/profile/data/models/specific_orders_model.dart';
import 'package:online_shopping/Features/profile/domain/repo_interface/profile_repo.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';
import 'package:online_shopping/core/utiles/is_same_day.dart';
import 'package:online_shopping/core/utiles/storage.dart';

class ProfileRepoImpl extends ProfileRepo {
  ProfileRepoImpl(this.storage);

  final Storage storage;

  @override
  Future<void> updateProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      String newImageURL = await storage.uploadFile(imagePicked.path, "/profile_images/${UserModel.getInstance().uid}/image");
      UserModel.getInstance().profilePicturePath = newImageURL;
      await Firestore.updateField(collectionPath: 'users', docName: UserModel.getInstance().uid, data: {'profilePicturePath': newImageURL});
    }
  }

  @override
  Future<void> deleteProfileImage() async {
    if (UserModel.getInstance().profilePicturePath != defaultProfileImage) {
      await storage.deleteFile(UserModel.getInstance().profilePicturePath);
      UserModel.getInstance().profilePicturePath = defaultProfileImage;
      await Firestore.updateField(collectionPath: 'users', docName: UserModel.getInstance().uid, data: {'profilePicturePath': defaultProfileImage});
    }
  }

  @override
  Future<List<OrderModel>> getMyTodayOrders(DateTime date) async {
    DocumentSnapshot res = await FirebaseFirestore.instance.collection('users').doc(UserModel.getInstance().uid).get();

    List<OrderModel> orders = [];
    for (Map order in res.get('orders')) {
      OrderModel orderModel = OrderModel.fromJson(order);
      if (isSameDay(orderModel.date, date)) {
        orders.add(orderModel);
      }
    }

    return orders;
  }

  @override
  Future<List<SpecificOrderModel>> getMyOrdersOnSpecificDate(DateTime date) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

    List<SpecificOrderModel> orders = [];

    for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
      for (int i = 0; i < snapshot.get('orders').length; i++) {
        SpecificOrderModel specificOrderModel = SpecificOrderModel.fromJson(snapshot, snapshot.get('orders')[i]);
        if (isSameDay(specificOrderModel.orderModel.date, date)) {
          orders.add(specificOrderModel);
        }
      }
    }

    return orders;
  }

  @override
  Future<void> savePassword(String newPassword) async {
    await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
  }

  @override
  Future<void> saveUserChanges(String name, DateTime dateOfBirth) async {
    UserModel user = UserModel(
      name: name,
      uid: UserModel.getInstance().uid,
      dateOfBirth: dateOfBirth.toIso8601String(),
      email: UserModel.getInstance().email,
      profilePicturePath: UserModel.getInstance().profilePicturePath,
      favourites: UserModel.getInstance().favourites,
      bag: UserModel.getInstance().bag,
      role: UserModel.getInstance().role,
    );
    UserModel.setInstance(user);
    await FirebaseFirestore.instance.collection('users').doc(UserModel.getInstance().uid).update(UserModel.getInstance().toMap());
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    UserModel.setInstance(null);
  }

  @override
  Future<void> deleteAccount() async {
    await FirebaseFirestore.instance.collection('users').doc(UserModel.getInstance().uid).delete();
    if (UserModel.getInstance().profilePicturePath != defaultProfileImage) {
      await storage.deleteFile(UserModel.getInstance().profilePicturePath);
    }
    await FirebaseAuth.instance.currentUser!.delete();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    UserModel.setInstance(null);
  }

  @override
  Future<List<ProductStatisticsModel>> getProductsBestSelling() async {
    QuerySnapshot ordersQuerySnapshot = await FirebaseFirestore.instance.collection('users').get();
    QuerySnapshot productsQuerySnapshot = await FirebaseFirestore.instance.collection('products').get();
    List<String> productsIDs = List<String>.generate(productsQuerySnapshot.docs.length, (int index) {
      return productsQuerySnapshot.docs[index].id;
    });

    Map<String, int> productsQuantities = {};
    for (QueryDocumentSnapshot queryDocumentSnapshot in ordersQuerySnapshot.docs) {
      for (dynamic json in queryDocumentSnapshot.get('orders')) {
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
