import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/data/models/product_review_model.dart';

abstract class ProductReviewsRepo {
  Future<void> createReview(Product product, ProductReviewModel newReview, String productId);
  bool checkUserExistance(Product product, String userId);
  Future<Product> refreshProduct(String productId);
}
