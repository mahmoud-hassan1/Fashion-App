import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_review_model.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/my_bag_repo.dart';
import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';

class MyBagRepoImpl extends MyBagRepo {
  MyBagRepoImpl(this.favouriteRepo, this.firestoreServices);

  final FavouriteRepo favouriteRepo;
  final FirestoreServices firestoreServices;
  final UserModel user = UserModel.getInstance();

  @override
  Future<List<ProductModel>> getMyBagItems() async {
    List<ProductModel> products = [];

    if (user.bag.isNotEmpty) {
      final QuerySnapshot result = await firestoreServices.getCollectionRef(productsCollectionKey).where(FieldPath.documentId, whereIn: user.bag).get();
      for (int i = 0; i < result.docs.length; i++) {
        products.add(ProductModel.fromJson(result.docs[i], result.docs[i].id));
      }
    }

    return products;
  }

  @override
  Future<void> checkOut(List<OrderItemModel> items) async {
    if (user.bag.isNotEmpty) {
      user.bag.clear();

      OrderModel orderModel = OrderModel(items: items, date: DateTime.now());
      DocumentReference doc = firestoreServices.getDocumentRef(usersCollectionKey, user.uid);

      await doc.update({UserModel.bagKey: []});
      await doc.update({
        OrderModel.ordersKey: FieldValue.arrayUnion([orderModel.toMap()])
      });
    }
  }

  @override
  Future<void> addToFavourites(String productUID) async {
    if (!user.favourites.contains(productUID)) {
      user.favourites.add(productUID);
      await favouriteRepo.addToFavourites(user.uid, productUID);
    }
  }

  @override
  Future<void> removeFromFavourites(String productUID) async {
    if (user.favourites.contains(productUID)) {
      user.favourites.remove(productUID);
      await favouriteRepo.removeFromFavourites(user.uid, productUID);
    }
  }

  @override
  Future<void> addToBag(String productUID) async {
    if (!user.bag.contains(productUID)) {
      user.bag.add(productUID);
      await firestoreServices.updateField(usersCollectionKey, user.uid, {UserModel.bagKey: user.bag});
    }
  }

  @override
  Future<void> deleteFromBag(String productUID) async {
    if (user.bag.contains(productUID)) {
      user.bag.remove(productUID);
      await firestoreServices.updateField(usersCollectionKey, user.uid, {UserModel.bagKey: user.bag});
    }
  }

  @override
  Future<void> addReview(OrderReviewModel review) async {
    DocumentReference doc = firestoreServices.getDocumentRef(usersCollectionKey, user.uid);
    List<dynamic> orders = (await doc.get()).get(OrderModel.ordersKey);
    orders.last[OrderReviewModel.reviewKey] = review.toMap();
    await doc.update({OrderModel.ordersKey: orders});
  }
}
