import 'package:online_shopping/Features/home/data/models/product_model.dart';

abstract class HomeRepo {
  Future<List<ProductModel>> getProductsByCategory(List<String> category);
  Future<List<ProductModel>> getNewestProducts();
  Future<List<ProductModel>> getProductsOnSale();
}

