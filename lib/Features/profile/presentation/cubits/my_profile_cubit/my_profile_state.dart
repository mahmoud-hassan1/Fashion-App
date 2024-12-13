part of 'my_profile_cubit.dart';

@immutable
sealed class MyProfileState {}

final class MyProfileInitial extends MyProfileState {}

final class MyProfileLoading extends MyProfileState {}

final class MyProfileGoToSplash extends MyProfileState {}

final class MyProfileFailed extends MyProfileState {}
