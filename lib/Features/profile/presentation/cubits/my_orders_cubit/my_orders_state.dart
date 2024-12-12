part of 'my_orders_cubit.dart';

@immutable
sealed class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}

final class MyOrdersLoading extends MyOrdersState {}

final class MyOrdersSuccess extends MyOrdersState {
  final List<SpecificOrderModel> orders;

  MyOrdersSuccess(this.orders);
}

final class MyOrdersFailed extends MyOrdersState {}
