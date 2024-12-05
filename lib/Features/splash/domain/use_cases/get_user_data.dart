import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/Features/splash/domain/repo/user_data_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserDataUseCase {
  final UserDataRepository _userDataRepository;

  GetUserDataUseCase(this._userDataRepository);

  Future<UserModel> call() async {
    try {
      return await _userDataRepository.getUserById();
    } catch (e) {
      if (e is FirebaseException) {
        throw Exception(e.message);
      } else {
        throw Exception("something went wrong");
      }
    }
  }
}
