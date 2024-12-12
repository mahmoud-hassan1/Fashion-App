part of 'profile_image_cubit.dart';

@immutable
sealed class ProfileImageState {}

final class ProfileImageInitial extends ProfileImageState {}

final class ProfileImageLoading extends ProfileImageState {}

final class ProfileImageFinished extends ProfileImageState {}

final class ProfileImageFailed extends ProfileImageState {}
