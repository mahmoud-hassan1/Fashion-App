import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/my_bag_repo.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit(this.bagRepo) : super(AddToCartInitial());

  final MyBagRepo bagRepo;

  Future<void> addToCart(String uid) async {
    try {
      await bagRepo.addToBag(uid);
      emit(AddToCartSuccessed());
    } catch (e) {
      emit(AddToCartFailed(message: e.toString()));
    }
  }
}
