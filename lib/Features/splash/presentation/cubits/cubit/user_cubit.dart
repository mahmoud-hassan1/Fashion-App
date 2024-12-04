import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_shopping/Features/splash/domain/use_cases/get_user_data.dart';
import 'package:online_shopping/core/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserDataUseCase getUserDataUseCase;

  UserCubit({required this.getUserDataUseCase}) : super(UserInitial());

  Future<void> getUserData() async {
    emit(UserLoading());
    try {
      final UserModel userData = await getUserDataUseCase.call();
      UserModel.setInstance(userData);
      emit(UserSuccess());
    } catch (e) {
      emit(UserFail(e.toString()));
    }
  }
}
