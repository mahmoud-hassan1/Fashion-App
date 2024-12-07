import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/data/models/review_model.dart';
import 'package:online_shopping/Features/reviews/domain/repo_interface/product_reviews_repo.dart';
import 'package:online_shopping/core/models/user_model.dart';

class ProductReviewsRepoImpl extends ProductReviewsRepo {
  @override
  Future<bool> createReview(Product product, ReviewModel newReview, String productId) async {
    bool isExist = checkUserExistance(product, UserModel.getInstance().uid);

    if (!isExist) {
      await FirebaseFirestore.instance.collection('products').doc(productId).update({
        'reviews': FieldValue.arrayUnion([newReview.toMap()])
      });
    }

    return isExist;
  }

  @override
  Future<Product> refreshProduct(String productId) async {
    DocumentSnapshot res = await FirebaseFirestore.instance.collection('products').doc(productId).get();
    return ProductModel.fromJson(res.data(), productId).toEntity();
  }

  @override
  bool checkUserExistance(Product product, String userId) {
    for (ReviewModel review in product.reviews) {
      if (review.userId == userId) {
        return true;
      }
    }

    return false;
  }
}
