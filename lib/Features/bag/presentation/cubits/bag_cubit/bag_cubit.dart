import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/data/mappers/order_mapper.dart';
import 'package:online_shopping/Features/bag/data/models/bag_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/bag_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/core/models/user_model.dart';

part 'bag_state.dart';

class MyBagCubit extends Cubit<MyBagState> {
  MyBagCubit({required this.repo}) : super(MyBagInitial());

  final BagRepo repo;
  late List<MyBagItemModel> bagItems;

  Future<void> getMyProducts() async {
    emit(MyBagLoading());

    try {
      List<ProductModel> products = await repo.getMyBagItems();
      bagItems = [];
      for (ProductModel product in products) {
        bagItems.add(MyBagItemModel(product: product));
      }

      emit(MyBagSuccessed(null, bagItems));
    } catch (e) {
      emit(MyBagFailed());
    }
  }

  double calculateTotalPrice() {
    if (bagItems.isEmpty) {
      return 0.0;
    }

    double sum = 0;
    for (MyBagItemModel ele in bagItems) {
      sum += ele.product.price * ele.quan;
    }

    return sum;
  }

  double updateTotalPrice() {
    emit(MyBagLoading());
    double sum = calculateTotalPrice();
    emit(MyBagSuccessed(null, bagItems));

    return sum;
  }

  Future<void> deleteItemFromBag(String productId) async {
    emit(MyBagLoading());

    try {
      await repo.deleteFromBag(productId);
      bagItems.removeWhere((ele) {
        return ele.product.id == productId;
      });

      emit(MyBagSuccessed(null, bagItems));
    } catch (_) {
      emit(MyBagFailed());
    }
  }

  Future<void> addToFavourites(String productId) async {
    emit(MyBagLoading());

    try {
      if (UserModel.getInstance().favourites.contains(productId)) {
        return emit(MyBagSuccessed("Product already in favourites", bagItems));
      }

      await repo.addToFavourites(productId);

      emit(MyBagSuccessed(null, bagItems));
    } catch (_) {
      emit(MyBagFailed());
    }
  }

  Future<void> checkOut() async {
    emit(MyBagLoading());

    try {
      List<OrderItemModel> orderItems = [];
      for (var item in bagItems) {
        orderItems.add(OrderMapper.toOrderItemModel(item));
      }

      await repo.checkOut(orderItems);
      bagItems = [];
      emit(MyBagSuccessed("Checkout done successfully", bagItems));
    } catch (_) {
      emit(MyBagFailed());
    }
  }
}
