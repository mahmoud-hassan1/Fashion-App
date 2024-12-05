import 'package:online_shopping/Features/splash/data/data_source/user_data_source.dart';
import 'package:online_shopping/Features/splash/domain/repo/user_data_repo.dart';
import 'package:online_shopping/core/models/user_model.dart';

class UserRepoImpl implements UserDataRepository {
  final UserDataSource userDataSource;

  UserRepoImpl(this.userDataSource);

  @override
  Future<UserModel> getUserById() async {
    return userDataSource.getUserById();
  }
}
