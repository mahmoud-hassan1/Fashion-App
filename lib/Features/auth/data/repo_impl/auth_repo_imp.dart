import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_shopping/Features/auth/data/models/signup_model.dart';
import 'package:online_shopping/Features/auth/domain/entities/user.dart';
import 'package:online_shopping/Features/auth/domain/repo_interface/auth_repo.dart';
import 'package:online_shopping/Features/splash/data/data_source/user_data_source.dart';
import 'package:online_shopping/Features/splash/data/repo/user_repo_impl.dart';
import 'package:online_shopping/core/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  const AuthRepositoryImpl({required this.firebaseFirestore, required this.firebaseAuth});

  @override
  Future<UserClass?> login(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    if (!firebaseAuth.currentUser!.emailVerified) {
      throw Exception("Verify your email");
    } else {
      final user = userCredential.user;
      if (user != null) {
        final user = await UserRepoImpl(UserDataSource(FirebaseFirestore.instance)).getUserById();
        UserModel.setInstance(user);
        return UserClass(uid: user.uid, email: user.email);
      }
      return null;
    }
  }

  Future<void> sendVerficationLink() async {
    await firebaseAuth.currentUser?.sendEmailVerification();
  }

  @override
  Future<UserClass?> signup(SignupModel model, String password) async {
    debugPrint("dsssssssssssss");
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: model.email, password: password);
    await sendVerficationLink();
    model.uid = userCredential.user!.uid;
    await firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(model.toMap(), SetOptions(merge: true));
    final user = userCredential.user;
    if (user != null) {
      user.updateDisplayName(model.name);
      return UserClass(uid: user.uid, email: user.email!);
    }
    return null;
  }

  @override
  Future<UserClass?> completeSignupWithGoogleProcess(DateTime dateOfBirth, String name, OAuthCredential credential) async {
    final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user != null) {
      SignupModel signupModel = SignupModel(email: user.email!, name: name, dateOfBirth: dateOfBirth, uid: user.uid);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(signupModel.toMap(), SetOptions(merge: true));
      final UserModel userData = await UserRepoImpl(UserDataSource(FirebaseFirestore.instance)).getUserById();
      UserModel.setInstance(userData);
      return UserClass(uid: user.uid, email: user.email!);
    }

    return null;
  }

  @override
  Future<(OAuthCredential, UserClass?)> googleSignup() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    UserClass? user = await checkUserExistance(googleUser.email);

    if (user != null) {
      await firebaseAuth.signInWithCredential(oAuthCredential);
      final user = await UserRepoImpl(UserDataSource(FirebaseFirestore.instance)).getUserById();
      UserModel.setInstance(user);
    }

    return (oAuthCredential, user);
  }

  @override
  Future<UserClass?> checkUserExistance(String email) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();

      SignupModel model = SignupModel.fromJson(query.docs.first.data());
      UserClass user = UserClass(uid: model.uid!, email: model.email);
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  void logout() {
    final user = firebaseAuth.currentUser;
    if (user!.providerData.any((provider) => provider.providerId == 'google.com')) {
      GoogleSignIn().signOut();
    }
    firebaseAuth.signOut();
  }

  @override
  Future<void> sendPasswordResetLink(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
