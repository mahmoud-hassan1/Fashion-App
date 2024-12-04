import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_shopping/Features/auth/data/models/signup_model.dart';
import 'package:online_shopping/Features/auth/domain/entities/user.dart';
import 'package:online_shopping/Features/auth/domain/repo_interface/auth_repo.dart';

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
        return UserClass(uid: user.uid, email: user.email!);
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
  Future<UserClass?> loginWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final userCredential = await firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user;

    if (user != null) {
      user.updateDisplayName(googleUser.displayName);
      return UserClass(uid: user.uid, email: user.email!);
    }
    return null;
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
