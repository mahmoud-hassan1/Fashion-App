import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_newest_products.dart';

part 'newest_state.dart';

class NewestCubit extends Cubit<NewestState> {
  final GetNewestProducts getNewestProducts;

  NewestCubit({required this.getNewestProducts}) : super(NewestInitial());

  Future<void> getNewestProductsOnSale() async {
    emit(NewestLoading());
    try {
      final products = await getNewestProducts.call();
      emit(NewestSuccess(products: products));
    } catch (e) {
      emit(NewestFail(message: 'Failed to load newest products: $e'));
    }
  }
}
