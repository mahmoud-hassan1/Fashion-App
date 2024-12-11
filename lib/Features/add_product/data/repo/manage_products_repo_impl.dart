import 'dart:io';

import 'package:online_shopping/Features/add_product/data/data_source/manage_products_data_source.dart';
import 'package:online_shopping/Features/add_product/domain/repo/manage_products_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

class ManageProductsRepoImpl extends ManageProductsRepo{
  final ManageProductsDataSource dataSource;

  ManageProductsRepoImpl({required this.dataSource});

  @override
  Future<void> addProduct({required ProductModel product, required List<File> selectedImages}) async{
      
      await dataSource.uploadProduct(product:product , selectedImages:selectedImages);
  }

}