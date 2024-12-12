part of 'my_orders_cubit.dart';

@immutable
sealed class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}

final class MyOrdersLoading extends MyOrdersState {}

final class MyOrdersUserSuccess extends MyOrdersState {
  final List<OrderModel> orders;

  MyOrdersUserSuccess(this.orders);
}

final class MyOrdersAdminSuccess extends MyOrdersState {
  final List<SpecificOrderModel> orders;

  MyOrdersAdminSuccess(this.orders);
}

final class MyOrdersFailed extends MyOrdersState {}
