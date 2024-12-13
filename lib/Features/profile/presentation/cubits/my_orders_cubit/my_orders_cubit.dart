import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/profile/data/models/specific_orders_model.dart';
import 'package:online_shopping/Features/profile/domain/repo_interface/profile_repo.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit(this.profileRepo) : super(MyOrdersInitial());

  final ProfileRepo profileRepo;

  Future<void> getMyOrdersOnSpecificDate(DateTime date) async {
    try {
      emit(MyOrdersLoading());
      List<SpecificOrderModel> orders = await profileRepo.getMyOrdersOnSpecificDate(date);
      emit(MyOrdersAdminSuccess(orders));
    } catch (_) {
      emit(MyOrdersFailed());
    }
  }

  Future<void> getMyOrders(DateTime date) async {
    try {
      emit(MyOrdersLoading());
      List<OrderModel> orders = await profileRepo.getMyTodayOrders(date);
      emit(MyOrdersUserSuccess(orders));
    } catch (_) {
      emit(MyOrdersFailed());
    }
  }
}
