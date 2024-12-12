import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/profile/domain/repo_interface/profile_repo.dart';

part 'profile_image_state.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  ProfileImageCubit(this.profileRepo) : super(ProfileImageInitial());

  final ProfileRepo profileRepo;

  Future<void> updateProfileImage() async {
    try {
      emit(ProfileImageLoading());
      await profileRepo.updateProfileImage();
      emit(ProfileImageFinished());
    } catch (_) {
      emit(ProfileImageFailed());
    }
  }

  Future<void> deleteImage() async {
    try {
      emit(ProfileImageLoading());
      await profileRepo.deleteProfileImage();
      emit(ProfileImageFinished());
    } catch (_) {
      emit(ProfileImageFailed());
    }
  }
}
