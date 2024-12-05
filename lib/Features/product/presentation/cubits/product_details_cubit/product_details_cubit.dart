import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/bag_repo.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.bagRepo) : super(ProductDetailsInitial());

  final BagRepo bagRepo;

  Future<void> addToCart(String productUID) async {
    emit(ProductDetailsLoading());

    try {
      await bagRepo.addToBag(productUID);
      emit(ProductDetailsAddedToCart());
    } catch (_) {
      emit(ProductDetailsFailed("Something went wrong!"));
    }
  }

  Future<void> addToFavourites(String productUID) async {
    emit(ProductDetailsLoading());

    try {
      await bagRepo.addToFavourites(productUID);
      emit(ProductDetailsSuccess());
    } catch (_) {
      emit(ProductDetailsFailed("Something went wrong!"));
    }
  }

  Future<void> removeFromFavourites(String productUID) async {
    emit(ProductDetailsLoading());

    try {
      await bagRepo.removeFromFavourites(productUID);
      emit(ProductDetailsSuccess());
    } catch (_) {
      emit(ProductDetailsFailed("Something went wrong!"));
    }
  }
}
