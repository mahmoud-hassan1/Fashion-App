import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/Features/auth/data/models/signup_model.dart';
import 'package:online_shopping/Features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  Future<UserClass?> login(String email, String password);
  Future<UserClass?> signup(SignupModel model, String password);
  Future<void> sendPasswordResetLink(String email);
  Future<UserClass?> completeSignupWithGoogleProcess(DateTime dateOfBirth, String name, OAuthCredential credential);
  Future<(OAuthCredential, UserClass?)> googleSignup();
  Future<UserClass?> checkUserExistance(String uid);
  Future<void> logout();
  Future<void> deleteAccount();
}
