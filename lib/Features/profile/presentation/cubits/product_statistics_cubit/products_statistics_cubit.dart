import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/profile/data/models/products_statistics_model.dart';
import 'package:online_shopping/Features/profile/domain/repo_interface/profile_repo.dart';

part 'products_statistics_state.dart';

class ProductsStatisticsCubit extends Cubit<ProductsStatisticsState> {
  ProductsStatisticsCubit(this.profileRepo) : super(ProductsStatisticsInitial());

  final ProfileRepo profileRepo;

  Future<void> getProductsBestSelling() async {
    try {
      emit(ProductsStatisticsLoading());
      List<ProductStatisticsModel> productStatistics = await profileRepo.getProductsBestSelling();
      emit(ProductsStatisticsSuccess(productStatistics));
    } catch (_) {
      emit(ProductsStatisticsFailed());
    }
  }
}
