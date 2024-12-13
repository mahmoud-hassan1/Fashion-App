import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/profile/domain/repo_interface/profile_repo.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit(this.profileRepo) : super(MyProfileInitial());

  final ProfileRepo profileRepo;

  Future<void> logout() async {
    emit(MyProfileLoading());
    try {
      await profileRepo.logout();
      emit(MyProfileGoToSplash());
    } catch (_) {
      emit(MyProfileFailed());
    }
  }

  Future<void> deleteAccount() async {
    emit(MyProfileLoading());
    try {
      await profileRepo.deleteAccount();
      emit(MyProfileGoToSplash());
    } catch (_) {
      emit(MyProfileFailed());
    }
  }
}
