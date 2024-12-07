import 'package:online_shopping/Features/home/data/models/product_model.dart';

abstract class ShopRepo {
  Future<List<ProductModel>> getProductsByCategory(List<String> category);
  Future<List<ProductModel>> getNewestProductsByCategory(List<String> category);
    Future<List<ProductModel>> getSaleProductsByCategory(List<String> category);
}
