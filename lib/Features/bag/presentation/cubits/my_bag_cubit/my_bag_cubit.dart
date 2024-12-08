import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/data/models/bag_item_model.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/bag_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/core/models/user_model.dart';

part 'my_bag_state.dart';

class MyBagCubit extends Cubit<MyBagState> {
  MyBagCubit({required this.repo}) : super(MyBagInitial());

  final BagRepo repo;
  List<MyBagItemModel>? items;

  Future<void> getMyProducts() async {
    emit(MyBagLoading());

    try {
      List<ProductModel> products = await repo.getMyBagItems();
      items = [];
      for (var product in products) {
        items!.add(MyBagItemModel(product: product));
      }

      emit(MyBagDataReceieved());
    } catch (e) {
      emit(MyBagFailed());
    }
  }

  double calculateTotalPrice() {
    if (items == null) {
      return 0.0;
    }

    double sum = 0;
    for (MyBagItemModel ele in items!) {
      sum += ele.product.price * ele.quan;
    }

    return sum;
  }

  double updateTotalPrice() {
    emit(MyBagLoading());
    double sum = calculateTotalPrice();
    emit(MyBagDataReceieved());

    return sum;
  }

  Future<void> deleteItemFromBag(String productId) async {
    emit(MyBagLoading());

    try {
      await repo.deleteFromBag(productId);
      items?.removeWhere((ele) {
        return ele.product.id == productId;
      });

      emit(MyBagDataReceieved());
    } catch (_) {
      emit(MyBagFailed());
    }
  }

  Future<void> addToFavourites(String productId) async {
    emit(MyBagLoading());

    try {
      if (UserModel.getInstance().favourites.contains(productId)) {
        return emit(MyBagAlreadyInFavourites());
      }

      await repo.addToFavourites(productId);

      emit(MyBagDataReceieved());
    } catch (_) {
      emit(MyBagFailed());
    }
  }

  Future<void> checkOut() async {
    emit(MyBagLoading());

    try {
      await repo.checkOut();
      items = [];
      emit(MyBagCheckOutDone());
    } catch (_) {
      emit(MyBagFailed());
    }
  }
}
