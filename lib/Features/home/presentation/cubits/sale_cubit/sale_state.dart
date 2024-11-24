part of 'sale_cubit.dart';

@immutable
sealed class SaleState {}

final class SaleInitial extends SaleState {}
final class SaleLoading extends SaleState {}
final class SaleSuccess extends SaleState {
  final List<Product> products;
  SaleSuccess({required this.products});
}
final class SaleFailed extends SaleState {
  final String message;
  SaleFailed({required this.message});
}
