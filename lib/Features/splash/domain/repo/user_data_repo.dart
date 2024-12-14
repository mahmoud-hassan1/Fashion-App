import 'package:online_shopping/core/models/user_model.dart';

abstract class UserDataRepo {
  Future<UserModel> getUserById();
}
