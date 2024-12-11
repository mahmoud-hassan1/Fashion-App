part of 'my_bag_cubit.dart';

@immutable
sealed class MyBagState {}

final class MyBagInitial extends MyBagState {}

final class MyBagLoading extends MyBagState {}

final class MyBagGoToOrderReview extends MyBagState {}

final class MyBagSuccessed extends MyBagState {
  final String? message;
  final List<MyBagItemModel> items;

  MyBagSuccessed(this.message, this.items);
}

final class MyBagFailed extends MyBagState {}
