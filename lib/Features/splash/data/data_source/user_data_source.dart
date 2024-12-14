import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/authentication_services.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';

class UserDataSource {
  final FirestoreServices firestoreServices;
  final AuthServices authServices;

  UserDataSource(this.firestoreServices, this.authServices);

  Future<UserModel> getUserById() async {
    final String uid = authServices.authInstance.currentUser!.uid;
    final snapshot = await firestoreServices.getDocumentData(usersCollectionKey, uid);
    return UserModel.fromJson(snapshot.data()!);
  }
}
