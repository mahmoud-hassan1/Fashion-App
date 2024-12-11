import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/data/models/order_review_model.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/my_bag_repo.dart';

part 'order_review_state.dart';

class OrderReviewCubit extends Cubit<OrderReviewState> {
  OrderReviewCubit(this.bagRepo) : super(OrderReviewInitial());

  final MyBagRepo bagRepo;

  Future<void> addOrderReview(OrderReviewModel review) async {
    emit(OrderReviewLoading());
    try {
      await bagRepo.addReview(review);
      emit(OrderReviewSuccess());
    } catch (_) {
      emit(OrderReviewFailed());
    }
  }
}
