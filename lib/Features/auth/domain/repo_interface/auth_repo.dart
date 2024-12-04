import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shopping/Features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserClass?> login(String email, String password);
  void logout();
  Future<UserClass?> signup(String name, String email, String password);
  Future<void> sendPasswordResetLink(String email);
  Future<UserClass?> completeSignupWithGoogleProcess(DateTime dateOfBirth, String name, OAuthCredential credential);
  Future<(OAuthCredential, UserClass?)> googleSignup();
  Future<UserClass?> checkUserExistance(String uid);
}
