import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/shop/data/data_source/shop_data_source.dart';
import 'package:online_shopping/Features/shop/domain/repo/shop_repo.dart';

class ShopRepoImpl implements ShopRepo {
  final ShopRemoteDataSource dataSource;

  const ShopRepoImpl(this.dataSource);

  @override
  Future<List<ProductModel>> getProductsByCategory(List<String> category) async {
    return await dataSource.getProductsByCategory(category);
  }

  @override
  Future<List<ProductModel>> getNewestProductsByCategory(List<String> category) async {
    return await dataSource.getNewestProductsByCategory(category);
  }

  @override
  Future<List<ProductModel>> getSaleProductsByCategory(List<String> category) async {
    return await dataSource.getSaleProductsByCategory(category);
  }
}
