import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping/Features/bag/data/models/order_model.dart';
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
      await Firestore.updateField(collectionPath: 'users', docName: UserModel.getInstance().uid, data: {'profileURL': newImageURL});
    }
  }

  @override
  Future<void> deleteProfileImage() async {
    if (UserModel.getInstance().profilePicturePath != defaultProfileImage) {
      await storage.deleteFile(UserModel.getInstance().profilePicturePath);
      UserModel.getInstance().profilePicturePath = defaultProfileImage;
      await Firestore.updateField(collectionPath: 'users', docName: UserModel.getInstance().uid, data: {'profileURL': defaultProfileImage});
    }
  }

  @override
  Future<List<OrderModel>> getMyTodayOrders() async {
    DocumentSnapshot res = await FirebaseFirestore.instance.collection('users').doc(UserModel.getInstance().uid).get();

    List<OrderModel> orders = [];
    for (Map order in res.get('orders')) {
      orders.add(OrderModel.fromJson(order));
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
}
