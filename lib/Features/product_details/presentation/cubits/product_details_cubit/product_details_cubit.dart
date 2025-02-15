import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/my_bag_repo.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/domain/repo_interface/product_reviews_repo.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.bagRepo, this.productReviewsRepo) : super(ProductDetailsInitial());

  final MyBagRepo bagRepo;
  final ProductReviewsRepo productReviewsRepo;

  Future<void> addToCart(String productUID) async {
    emit(ProductDetailsLoading());

    try {
      await bagRepo.addToBag(productUID);
      emit(ProductDetailsAddedToCart());
    } catch (e) {
      emit(ProductDetailsFailed(e.toString().replaceFirst('Exception:', '').trim()));
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
