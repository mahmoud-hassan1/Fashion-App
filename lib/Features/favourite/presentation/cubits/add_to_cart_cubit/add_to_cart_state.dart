part of 'add_to_cart_cubit.dart';

@immutable
sealed class AddToCartState {}

final class AddToCartInitial extends AddToCartState {}

final class AddToCartLoading extends AddToCartState {}

final class AddToCartSuccessed extends AddToCartState {}

final class AddToCartFailed extends AddToCartState {
  final String message;

  AddToCartFailed({required this.message});
}
