import 'package:online_shopping/Features/home/data/models/product_model.dart';

abstract class BagRepo {
  Future<List<ProductModel>> getMyBagItems();
  Future<void> checkOut();
  Future<void> deleteFromBag(String productUID);
  Future<void> addToBag(String productUID);
  Future<void> addToFavourites(String productUID);
  Future<void> removeFromFavourites(String productUID);
}
