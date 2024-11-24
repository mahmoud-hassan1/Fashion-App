import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/home/domain/repos/home_repo.dart';

class GetSaleProducts {
  final HomeRepo repository;

  GetSaleProducts(this.repository);

  Future<List<Product>> call() async {
    try {
      final productModels = await repository.getProductsOnSale();
      return productModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load sale products: $e'); 
    }
  }
}

