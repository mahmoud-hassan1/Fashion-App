import 'dart:io';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

abstract class ManageProductsRepo {
  Future<void> addProduct({required ProductModel product, required List<File> selectedImages});
  Future<void> editProduct({required ProductModel product});
  Future<void> deleteProduct({required ProductModel product});
}
