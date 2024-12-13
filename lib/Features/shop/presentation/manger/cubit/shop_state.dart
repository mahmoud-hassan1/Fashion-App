part of 'shop_cubit.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class ShopLoadingState extends ShopState {}

final class ShopLoadedState extends ShopState {
  final List<Product> products;

  ShopLoadedState({required this.products});
}

final class ShopErrorState extends ShopState {
  final String message;

  ShopErrorState({required this.message});
}
