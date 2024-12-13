import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/domain/repo_interface/home_repo.dart';

class GetNewestProducts {
  final HomeRepo repository;

  GetNewestProducts(this.repository);

  Future<List<Product>> call() async {
    try {
      final productModels = await repository.getNewestProducts();
      return productModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load newest products: $e');
    }
  }
}
