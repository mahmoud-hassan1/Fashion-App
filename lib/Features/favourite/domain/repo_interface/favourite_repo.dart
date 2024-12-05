import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';

abstract class FavouriteRepo {
  Future<List<Product>>getFavouritsProduct();
  Future<void> addToFavourites(String userId, String productId);
  Future<void> removeFromFavourites(String userId, String productId);
}
