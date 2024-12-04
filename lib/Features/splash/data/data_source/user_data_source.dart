import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/core/models/user_model.dart';

class UserDataSource {
  final FirebaseFirestore firestore;

  UserDataSource(this.firestore);

  Future<UserModel> getUserById() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await firestore.collection('users').doc(uid).get();
    return UserModel.fromJson(snapshot.data()!);
  }
}
