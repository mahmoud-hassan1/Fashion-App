// lib/Features/home/domain/usecases/get_products_by_category.dart
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/shop/domain/repo/shop_repo.dart';

class GetProductsByCategory {
  final ShopRepo repository;

  GetProductsByCategory(this.repository);

  Future<List<Product>> call(List<String> category) async {
    try {
      final productModels = await repository.getProductsByCategory(category);
      var products = productModels.map((model) => model.toEntity()).toList();
      products = products.where((product) => category.every((cat) => product.categories.contains(cat))).toList();
      return products;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
