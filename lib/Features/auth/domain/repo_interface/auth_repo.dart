import 'package:online_shopping/Features/auth/data/models/signup_model.dart';
import 'package:online_shopping/Features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserClass?> login(String email, String password);
  void logout();
  Future<UserClass?> signup(SignupModel model, String password);
  Future<void> sendPasswordResetLink(String email);
  Future<UserClass?> loginWithGoogle();
}
