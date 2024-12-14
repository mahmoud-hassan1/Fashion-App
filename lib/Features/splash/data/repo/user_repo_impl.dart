import 'package:online_shopping/Features/splash/data/data_source/user_data_source.dart';
import 'package:online_shopping/Features/splash/domain/repo/user_data_repo.dart';
import 'package:online_shopping/core/models/user_model.dart';

class UserDataRepoImpl implements UserDataRepo {
  final UserDataSource userDataSource;

  UserDataRepoImpl(this.userDataSource);

  @override
  Future<UserModel> getUserById() async {
    return userDataSource.getUserById();
  }
}
