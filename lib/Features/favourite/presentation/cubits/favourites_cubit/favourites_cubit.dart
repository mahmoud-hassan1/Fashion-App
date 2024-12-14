import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/favourite/domain/use_cases/get_favourites_poducts.dart';
import 'package:online_shopping/core/models/user_model.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final GetFavouritesPoductsUseCase getFavouritesPoductsUseCase;

  FavouritesCubit(this.getFavouritesPoductsUseCase) : super(FavouritesInitial());

  Future<void> getFavouritesProducts() async {
    emit(FavouritesLoading());
    try {
      if (UserModel.getInstance().favourites.isNotEmpty) {
        final products = await getFavouritesPoductsUseCase.call();
        emit(FavouritesSuccess(products));
      } else {
        emit(FavouritesSuccess(const []));
      }
    } catch (e) {
      emit(FavouritesFail('Failed to load favourites products: $e'));
    }
  }
}
