import 'dart:io';

import 'package:online_shopping/Features/add_product/domain/repo/manage_products_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

class UploadProductUsecase {
  final ManageProductsRepo repository;

  UploadProductUsecase({required this.repository});

  Future<void> call({
    required ProductModel product,
    required List<File> selectedImages,
  }) async {
    try {
      await repository.addProduct(product: product, selectedImages: selectedImages);
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }
}
