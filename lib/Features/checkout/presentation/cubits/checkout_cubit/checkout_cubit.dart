import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
}
