// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ConstantNames {
  static const String usernameCollection = 'UsernameCollection';
  static const String usersCollection = 'UsersCollection';
  static const String fullName = 'FullName';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String uid = 'UID';
  static const String username = 'Username';
  static const String phone = 'Phone';
}

class SignIn {
  static Future<UserCredential> signIn(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithUid(String uid) async {
    return await FirebaseAuth.instance.signInWithCredential(EmailAuthProvider.credential(email: '', password: ''));
  }
}

class AccountData {
  // Username
  static Future<String?> getUsernameFromFirestore(String uid) async {
    var d = await FirebaseFirestore.instance.collection(ConstantNames.usernameCollection).doc(uid).get();
    return d.data()![ConstantNames.username];
  }

  // Email
  static Future<String?> getEmailFromFirestore(String uid) async {
    var d = await FirebaseFirestore.instance.collection(ConstantNames.usernameCollection).doc(uid).get();
    return d.data()![ConstantNames.email];
  }

  static Future<String?> getEmailFromFirebaseAuth(String uid) async {
    User? user = await FirebaseAuth.instance.userChanges().firstWhere((user) => user!.uid == uid);
    return user?.email;
  }

  // Phone
  static Future<String?> getPhoneNumberFromFirestore(String uid) async {
    var d = await FirebaseFirestore.instance.collection(ConstantNames.usernameCollection).doc(uid).get();
    return d.data()![ConstantNames.phone];
  }

  // UID
  static Future<String?> getUIDFromFirestore(String username) async {
    QuerySnapshot uidDocument = await FirebaseFirestore.instance.collection(ConstantNames.usernameCollection).where(ConstantNames.username, isEqualTo: username).limit(1).get();
    return uidDocument.docs[0].id;
  }

  // Password
  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // Get All User Data From Firestore
  static Future<Map<String, dynamic>?> getUserDataFromFirestore(String uid) async {
    // return user data without password
    var data = await FirebaseFirestore.instance.collection(ConstantNames.usernameCollection).doc(uid).get();
    return data.data();
  }
}

class Register {
  static Future<UserCredential> register(Map<String, dynamic> userData, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userData[ConstantNames.email], password: password);
    userData[ConstantNames.uid] = userCredential.user!.uid;
    await FirebaseFirestore.instance.collection(ConstantNames.usernameCollection).doc(userCredential.user!.uid).set(userData, SetOptions(merge: true));
    return userCredential;
  }
}

class SignOut {
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> deleteAccount(String uid, String email) async {
    await FirebaseFirestore.instance.collection(ConstantNames.usernameCollection).doc(uid).delete();
    await FirebaseFirestore.instance.collection(ConstantNames.usersCollection).doc(email).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }
}

class Verification {
  static Future<void> sendVerification() async {
    return await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  static bool isVerified() {
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }
}

// For Authentication
// in cmd --> flutter pub add firebase_core
// in cmd --> flutter pub add firebase_auth
// in cmd --> flutter pub add cloud_firestore
// in cmd --> flutter pub add google_sign_in
