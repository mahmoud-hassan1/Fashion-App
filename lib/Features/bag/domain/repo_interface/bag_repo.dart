import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_review_model.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

abstract class BagRepo {
  Future<List<ProductModel>> getMyBagItems();
  Future<void> checkOut(List<OrderItemModel> items);
  Future<void> deleteFromBag(String productUID);
  Future<void> addToBag(String productUID);
  Future<void> addToFavourites(String productUID);
  Future<void> removeFromFavourites(String productUID);
  Future<void> addReview(OrderReviewModel review);
}
