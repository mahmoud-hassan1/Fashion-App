// lib/Features/home/domain/usecases/get_products_by_category.dart
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/domain/repo_interface/home_repo.dart';
class GetProductsByCategory {
  final HomeRepo repository;

  GetProductsByCategory(this.repository);

  Future<List<Product>> call(List<String> category) async {
    try {
      final productModels = await repository.getProductsByCategory(category);
      return productModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e'); 
    }
  }
}