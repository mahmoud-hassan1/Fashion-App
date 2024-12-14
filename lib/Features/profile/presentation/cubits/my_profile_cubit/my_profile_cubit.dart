import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/auth/data/repo_impl/auth_repo_imp.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit(this.authRepositoryImpl) : super(MyProfileInitial());

  final AuthRepoImpl authRepositoryImpl;

  Future<void> logout() async {
    emit(MyProfileLoading());
    try {
      await authRepositoryImpl.logout();
      emit(MyProfileGoToSplash());
    } catch (_) {
      emit(MyProfileFailed());
    }
  }

  Future<void> deleteAccount() async {
    emit(MyProfileLoading());
    try {
      await authRepositoryImpl.deleteAccount();
      emit(MyProfileGoToSplash());
    } catch (_) {
      emit(MyProfileFailed());
    }
  }
}
