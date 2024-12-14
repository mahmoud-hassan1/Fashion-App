import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/profile/domain/repo_interface/profile_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.profileRepo) : super(SettingsInitial());
  final ProfileRepo profileRepo;

  Future<void> savePassword(String password) async {
    emit(SettingsLoading());
    try {
      if (password.isEmpty) {
        emit(SettingsInvalidData());
      }
      await profileRepo.savePassword(password);
      emit(SettingsSuccessed());
    } catch (e) {
      emit(SettingsFailed(errorMessage: e.toString()));
    }
  }

  Future<void> saveChanges(String name, DateTime dateOfBirth) async {
    emit(SettingsLoading());
    try {
      if (name.isEmpty) {
        emit(SettingsInvalidData());
      }
      await profileRepo.saveUserChanges(name, dateOfBirth);
      emit(SettingsSuccessed());
    } catch (e) {
      emit(SettingsFailed(errorMessage: e.toString()));
    }
  }
}
