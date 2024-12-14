import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/Features/reviews/data/models/review_model.dart';
import 'package:online_shopping/Features/reviews/domain/repo_interface/product_reviews_repo.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';

class ProductReviewsRepoImpl extends ProductReviewsRepo {
  ProductReviewsRepoImpl(this.firestoreServices);

  final FirestoreServices firestoreServices;

  @override
  Future<bool> createReview(Product product, ReviewModel newReview, String productId) async {
    bool isExist = checkUserExistance(product, UserModel.getInstance().uid);

    if (!isExist) {
      await firestoreServices.updateField(productsCollectionKey, productId, {
        ProductModel.reviewsKey: FieldValue.arrayUnion([newReview.toMap()])
      });
    }

    return isExist;
  }

  @override
  Future<Product> refreshProduct(String productId) async {
    DocumentSnapshot res = await firestoreServices.getDocumentData(productsCollectionKey, productId);
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
