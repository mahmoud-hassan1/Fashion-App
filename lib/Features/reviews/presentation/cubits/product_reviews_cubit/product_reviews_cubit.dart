import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/data/models/product_review_model.dart';
import 'package:online_shopping/Features/reviews/domain/repo_interface/product_reviews_repo.dart';
import 'package:online_shopping/core/models/user_model.dart';

part 'product_reviews_state.dart';

class ProductReviewsCubit extends Cubit<ProductReviewsState> {
  ProductReviewsCubit(this.reviewsRepo) : super(ProductReviewsInitial());

  final ProductReviewsRepo reviewsRepo;

  Future<void> createReview(Product product, ReviewModel reviewModel, String productId) async {
    emit(ProductReviewsLoading());
    try {
      if (reviewsRepo.checkUserExistance(product, UserModel.getInstance().uid)) {
        emit(ProductReviewsFailed("You already write a review for this product."));
      }
      
      await reviewsRepo.createReview(product, reviewModel, productId);
      emit(ProductReviewsSuccess());
    } catch (_) {
      emit(ProductReviewsFailed("Something went wrong!"));
    }
  }
}
