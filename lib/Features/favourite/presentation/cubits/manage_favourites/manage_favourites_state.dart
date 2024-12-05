part of 'manage_favourites_cubit.dart';

@immutable
sealed class ManageFavouritesState {}

final class ManageFavouritesInitial extends ManageFavouritesState {}

final class ManageFavouritesLoading extends ManageFavouritesState {}

final class ManageFavouritesError extends ManageFavouritesState {
  final String error;

  ManageFavouritesError({required this.error});
}

final class ManageFavouritesSuccess extends ManageFavouritesState {
  final String productId;

  ManageFavouritesSuccess({required this.productId});
}
