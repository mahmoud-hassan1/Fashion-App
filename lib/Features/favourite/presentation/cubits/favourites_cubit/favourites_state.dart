part of 'favourites_cubit.dart';

@immutable
sealed class FavouritesState {}

final class FavouritesInitial extends FavouritesState {}

final class FavouritesSuccess extends FavouritesState {
  final List<Product> products;

  FavouritesSuccess(this.products);
}

final class FavouritesFail extends FavouritesState {
  final String message;

  FavouritesFail(this.message);
}

final class FavouritesLoading extends FavouritesState {}
