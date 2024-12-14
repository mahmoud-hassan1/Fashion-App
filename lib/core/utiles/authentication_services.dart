import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';

class AuthServices {
  AuthServices();

  late final FirebaseAuth authInstance = FirebaseAuth.instance;
  late final FirestoreServices firebaseFirestoreServices = FirestoreServices();
  late final SignInServices signInServices = SignInServices._(authInstance);
  late final AccountDataServices accountDataServices = AccountDataServices._(authInstance, firebaseFirestoreServices);
  late final RegisterServices registerServices = RegisterServices._(authInstance, firebaseFirestoreServices);
  late final SignOutServices signOutServices = SignOutServices._(authInstance, firebaseFirestoreServices);
  late final Verification verification = Verification._(authInstance);
}

class SignInServices {
  const SignInServices._(this.authInstance);

  final FirebaseAuth authInstance;

  Future<UserCredential> signIn(String email, String password) async {
    return await authInstance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<(OAuthCredential, GoogleSignInAccount?)> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (credential, googleUser);
  }

  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    return await authInstance.signInWithCredential(credential);
  }
}

class AccountDataServices {
  const AccountDataServices._(this.authInstance, this.firebaseFirestoreServices);

  final FirestoreServices firebaseFirestoreServices;
  final FirebaseAuth authInstance;

  Future<String?> getEmailFromFirestore(String uid) async {
    var doc = await firebaseFirestoreServices.getDocumentData(usersCollectionKey, uid);
    return doc.data()![UserModel.emailKey];
  }

  Future<String?> getEmailFromFirebaseAuth(String uid) async {
    User? user = await authInstance.userChanges().firstWhere((user) => user!.uid == uid);
    return user?.email;
  }

  Future<String?> getPhoneNumberFromFirestore(String uid) async {
    var doc = await firebaseFirestoreServices.getDocumentData(usersCollectionKey, uid);
    return doc.data()![UserModel.emailKey];
  }

  Future<String?> getUIDFromFirestore(String email) async {
    QuerySnapshot uidDocument = await firebaseFirestoreServices.firestoreInstance.collection(usersCollectionKey).where(UserModel.emailKey, isEqualTo: email).limit(1).get();
    return uidDocument.docs[0].id;
  }

  Future<Map<String, dynamic>?> getUserDataFromFirestore(String uid) async {
    var doc = await firebaseFirestoreServices.getDocumentData(usersCollectionKey, uid);
    return doc.data();
  }

  Future<void> sendPasswordReset(String email) async {
    return await authInstance.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePassword(String newPassword) async {
    return await authInstance.currentUser?.updatePassword(newPassword);
  }
}

class RegisterServices {
  const RegisterServices._(this.authInstance, this.firebaseFirestoreServices);

  final FirestoreServices firebaseFirestoreServices;
  final FirebaseAuth authInstance;

  Future<UserCredential> register(Map<String, dynamic> userData, String email, String password) async {
    UserCredential userCredential = await authInstance.createUserWithEmailAndPassword(email: email, password: password);
    userData[UserModel.uidKey] = userCredential.user!.uid;
    await firebaseFirestoreServices.setDocument(usersCollectionKey, userData, userCredential.user!.uid);
    return userCredential;
  }
}

class SignOutServices {
  const SignOutServices._(this.authInstance, this.firebaseFirestoreServices);

  final FirestoreServices firebaseFirestoreServices;
  final FirebaseAuth authInstance;

  Future<void> signOut() async {
    await authInstance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<void> deleteAccount(String uid) async {
    firebaseFirestoreServices.deleteDoc(usersCollectionKey, uid);
    await authInstance.currentUser!.delete();
    await signOut();
  }
}

class Verification {
  const Verification._(this.authInstance);

  final FirebaseAuth authInstance;

  Future<void> sendVerification() async {
    return await authInstance.currentUser!.sendEmailVerification();
  }

  bool isVerified() {
    return authInstance.currentUser!.emailVerified;
  }
}
