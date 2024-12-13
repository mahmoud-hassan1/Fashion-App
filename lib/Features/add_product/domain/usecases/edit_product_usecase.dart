import 'package:online_shopping/Features/add_product/domain/repo/manage_products_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

class EditProductUsecase {
  final ManageProductsRepo repository;

  EditProductUsecase({required this.repository});

  Future<void> call({required ProductModel product}) async {
    try {
      await repository.editProduct(
        product: product,
      );
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }
}
