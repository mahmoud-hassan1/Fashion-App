part of 'manage_products_cubit.dart';

@immutable
sealed class ManageProductsState {}

final class ManageProductsInitial extends ManageProductsState {}

final class AddProductsSucsses extends ManageProductsState {
  
}

final class AddProductsFailed extends ManageProductsState {
  final String error;
   AddProductsFailed({required this.error });
}

final class AddProductsLoading extends ManageProductsState {}