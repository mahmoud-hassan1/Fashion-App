import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_newest_products_by_cat.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_products_by_cat.dart';
import 'package:online_shopping/Features/shop/domain/use_cases/get_sale_products_by_cat.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final GetNewestProductsByCategory getNewestProductsByCategory;
  final GetProductsByCategory getProductsByCategory;
  final GetSaleProductsByCategory getSaleProductsByCategory;
  ShopCubit({
    required this.getSaleProductsByCategory,
    required this.getNewestProductsByCategory,
    required this.getProductsByCategory,
  }) : super(ShopInitial());

  Future<void> fetchNewestProductsByCategory(List<String> category) async {
    emit(ShopLoadingState());
    try {
      final products = await getNewestProductsByCategory.call(category);

      emit(ShopLoadedState(products: products));
    } catch (e) {
      emit(ShopErrorState(message: 'Failed to load newest products: $e'));
    }
  }

  Future<void> fetchProductsByCategory(List<String> category) async {
    emit(ShopLoadingState());
    try {
      final products = await getProductsByCategory.call(category);
      emit(ShopLoadedState(products: products));
    } catch (e) {
      emit(ShopErrorState(message: 'Failed to load products: $e'));
    }
  }

  Future<void> fetchSaleProductsByCategory(List<String> category) async {
    emit(ShopLoadingState());
    try {
      final products = await getSaleProductsByCategory.call(category);
      emit(ShopLoadedState(products: products));
    } catch (e) {
      emit(ShopErrorState(message: 'Failed to load products: $e'));
    }
  }
}
