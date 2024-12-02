import 'package:bloc/bloc.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/domain/use_cases/get_sale_products.dart';

part 'sale_state.dart';

class SaleCubit extends Cubit<SaleState> {
  final GetSaleProducts getSaleProducts;
  SaleCubit({required this.getSaleProducts}) : super(SaleInitial());

  Future<void> getProductsOnSale() async {
    emit(SaleLoading());
    try {
      final products = await getSaleProducts.call();
      emit(SaleSuccess(products: products));
    } catch (e) {
      emit(SaleFailed(message: 'Failed to load sale products: $e'));
    }
  }
}
