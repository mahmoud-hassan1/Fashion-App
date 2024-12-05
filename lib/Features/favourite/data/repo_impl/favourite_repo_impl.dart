import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/favourite/data/data_source/favourites_data_source.dart';
import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';

class FavouriteRepoImpl extends FavouriteRepo {
    final FirebaseFirestore firestore;
  final FavouritesDataSource dataSource;

  FavouriteRepoImpl({required this.firestore}) : dataSource = FavouritesDataSource(firestore);
  @override
  Future<List<Product>> getFavouritsProduct() async {
    final products = await dataSource.getProductsById();
    return products.map((model) => model.toEntity()).toList();
  }
  @override
  Future<void> addToFavourites(String userId, String productId) async {
    await dataSource.addToFavourites(userId, productId);
  }
  @override
  Future<void> removeFromFavourites(String userId, String productId) async {
    await dataSource.removeFromFavourites(userId, productId);
  }
}
