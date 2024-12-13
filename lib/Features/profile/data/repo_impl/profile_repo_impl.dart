import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
}
