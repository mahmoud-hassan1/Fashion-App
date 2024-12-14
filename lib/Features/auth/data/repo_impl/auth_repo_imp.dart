import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_shopping/Features/auth/data/models/signup_model.dart';
import 'package:online_shopping/Features/auth/domain/entities/user.dart';
import 'package:online_shopping/Features/auth/domain/repo_interface/auth_repo.dart';
import 'package:online_shopping/Features/splash/domain/repo/user_data_repo.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/authentication_services.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';
import 'package:online_shopping/core/utiles/storage_services.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this.userDataRepository, this.authServices, this.firestoreServices, this.storageServices);

  final UserDataRepo userDataRepository;
  final AuthServices authServices;
  final FirestoreServices firestoreServices;
  final StorageServices storageServices;
  UserModel user = UserModel.getInstance();

  @override
  Future<UserClass?> login(String email, String password) async {
    final userCredential = await authServices.signInServices.signIn(email, password);
    if (!authServices.authInstance.currentUser!.emailVerified) {
      throw Exception("Verify your email");
    } else {
      final user = userCredential.user;
      if (user != null) {
        final user = await userDataRepository.getUserById();
        UserModel.setInstance(user);
        return UserClass(uid: user.uid, email: user.email);
      }
      return null;
    }
  }

  Future<void> sendVerficationLink() async {
    return await authServices.verification.sendVerification();
  }

  @override
  Future<UserClass?> signup(SignupModel model, String password) async {
    final UserCredential userCredential = await authServices.registerServices.register(model.toMap(), model.email, password);
    await sendVerficationLink();

    final user = userCredential.user;
    if (user != null) {
      user.updateDisplayName(model.name);
      return UserClass(uid: user.uid, email: user.email!);
    }
    return null;
  }

  @override
  Future<UserClass?> completeSignupWithGoogleProcess(DateTime dateOfBirth, String name, OAuthCredential credential) async {
    final UserCredential userCredential = await authServices.signInServices.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      SignupModel signupModel = SignupModel(email: user.email!, name: name, dateOfBirth: dateOfBirth, uid: user.uid);
      await firestoreServices.setDocument(usersCollectionKey, signupModel.toMap(), user.uid);
      final UserModel userData = await userDataRepository.getUserById();
      UserModel.setInstance(userData);
      return UserClass(uid: user.uid, email: user.email!);
    }

    return null;
  }

  @override
  Future<(OAuthCredential, UserClass?)> googleSignup() async {
    final (OAuthCredential oAuthCredential, GoogleSignInAccount? googleUser) = await authServices.signInServices.signInWithGoogle();
    UserClass? user = await checkUserExistance(googleUser!.email);

    if (user != null) {
      await authServices.signInServices.signInWithCredential(oAuthCredential);
      final user = await userDataRepository.getUserById();
      UserModel.setInstance(user);
    }

    return (oAuthCredential, user);
  }

  @override
  Future<UserClass?> checkUserExistance(String email) async {
    try {
      QuerySnapshot query = await firestoreServices.getCollectionRef(usersCollectionKey).where(UserModel.emailKey, isEqualTo: email).get();
      SignupModel model = SignupModel.fromJson(query.docs.first.data());
      UserClass user = UserClass(uid: model.uid!, email: model.email);
      return user;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    await authServices.signOutServices.signOut();
    UserModel.setInstance(null);
  }

  @override
  Future<void> deleteAccount() async {
    if (user.profilePicturePath != defaultProfileImage) {
      await storageServices.deleteFile(user.profilePicturePath);
    }

    await authServices.signOutServices.deleteAccount(user.uid);
    UserModel.setInstance(null);
  }

  @override
  Future<void> sendPasswordResetLink(String email) async {
    await authServices.accountDataServices.sendPasswordReset(email);
  }
}
