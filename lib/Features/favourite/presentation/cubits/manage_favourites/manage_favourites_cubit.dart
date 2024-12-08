import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/add_to_favourites.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/remove_from_favourites.dart';
import 'package:online_shopping/core/models/user_model.dart';

part 'manage_favourites_state.dart';

class ManageFavouritesCubit extends Cubit<ManageFavouritesState> {
  final AddToFavouritesUseCase addToFavouritesUseCase;
  final RemoveFromFavouritesUseCase removeFromFavouritesUseCase;

  ManageFavouritesCubit({
    required this.addToFavouritesUseCase,
    required this.removeFromFavouritesUseCase,
  }) : super(ManageFavouritesInitial());

  Future<void> addToFavourites(String productId) async {
    try {
      await addToFavouritesUseCase.call(UserModel.getInstance().uid, productId);
      UserModel.getInstance().favourites.add(productId);
      emit(ManageFavouritesSuccess(productId: productId));
    } catch (e) {
      emit(ManageFavouritesError(error: 'Failed to add to favourites: $e'));
    }
  }

  Future<void> removeFromFavourites(String productId) async {
    try {
      await removeFromFavouritesUseCase.call(UserModel.getInstance().uid, productId);
      UserModel.getInstance().favourites.remove(productId);
      emit(ManageFavouritesSuccess(productId: productId));
    } catch (e) {
      emit(ManageFavouritesError(error: 'Failed to remove from favourites: $e'));
    }
  }

  bool isFavourite({required String productId}) {
    return UserModel.getInstance().favourites.contains(productId);
  }

  void emitState() {
    emit(ManageFavouritesSuccess(productId: ""));
  }
}
