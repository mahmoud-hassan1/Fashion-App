import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/shop/domain/repo/shop_repo.dart';

class GetSaleProductsByCategory {
  final ShopRepo repository;

  GetSaleProductsByCategory(this.repository);

  Future<List<Product>> call(List<String> category) async {
    try {
      final productModels = await repository.getSaleProductsByCategory(category);
      print(productModels);
      return productModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load newest products: $e'); 
    }
  }
}

