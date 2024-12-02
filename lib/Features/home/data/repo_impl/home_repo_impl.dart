// lib/Features/home/data/repositories/home_repo_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/domain/repo_interface/home_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/home/data/data_source/home_data_source.dart';

class HomeRepoImpl implements HomeRepo {
  final FirebaseFirestore firestore;
  final HomeRemoteDataSource dataSource;

  HomeRepoImpl({required this.firestore}) : dataSource = HomeRemoteDataSource(firestore);

  @override
  Future<List<ProductModel>> getNewestProducts() async {
    return await dataSource.getNewestProducts();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(List<String> category) async {
    return await dataSource.getProductsByCategory(category);
  }

  @override
  Future<List<ProductModel>> getProductsOnSale() async {
    return await dataSource.getProductsOnSale();
  }
}
