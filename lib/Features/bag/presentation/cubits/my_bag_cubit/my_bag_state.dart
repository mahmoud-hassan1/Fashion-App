part of 'my_bag_cubit.dart';

@immutable
sealed class MyBagState {}

final class MyBagInitial extends MyBagState {}

final class MyBagLoading extends MyBagState {}

final class MyBagDataReceieved extends MyBagState {}

final class MyBagCheckOutDone extends MyBagState {}

final class MyBagFailed extends MyBagState {}

final class MyBagAlreadyInFavourites extends MyBagState {}
