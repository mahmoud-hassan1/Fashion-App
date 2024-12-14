// lib/Features/home/data/repositories/home_repo_impl.dart
import 'package:online_shopping/Features/home/domain/repo_interface/home_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/home/data/data_source/home_data_source.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource dataSource;

  const HomeRepoImpl(this.dataSource);

  @override
  Future<List<ProductModel>> getNewestProducts() async {
    return await dataSource.getNewestProducts();
  }

  @override
  Future<List<ProductModel>> getProductsOnSale() async {
    return await dataSource.getProductsOnSale();
  }
}
