import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/bag_repo.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/domain/repo_interface/product_reviews_repo.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.bagRepo, this.productReviewsRepo) : super(ProductDetailsInitial());

  final BagRepo bagRepo;
  final ProductReviewsRepo productReviewsRepo;

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

  Future<void> refresh(String productUID) async {
    emit(ProductDetailsLoading());

    try {
      final Product product = await productReviewsRepo.refreshProduct(productUID);
      emit(ProductDetailsRefresh(product));
    } catch (_) {
      emit(ProductDetailsFailed("Something went wrong!"));
    }
  }
}
