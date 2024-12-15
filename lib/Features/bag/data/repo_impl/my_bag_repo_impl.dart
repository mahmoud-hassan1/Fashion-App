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

  @override
  Future<List<ProductModel>> getMyBagItems() async {
    List<ProductModel> products = [];

    if (UserModel.getInstance().bag.isNotEmpty) {
      final QuerySnapshot result = await firestoreServices.getCollectionRef(productsCollectionKey).where(FieldPath.documentId, whereIn: UserModel.getInstance().bag).get();
      for (int i = 0; i < result.docs.length; i++) {
        if(result.docs[i]['stock']>0) {
          products.add(ProductModel.fromJson(result.docs[i], result.docs[i].id));
        }
      }
    }

    return products;
  }

  @override
  Future<void> checkOut(List<OrderItemModel> items) async {
    if (UserModel.getInstance().bag.isNotEmpty) {
      UserModel.getInstance().bag.clear();

      OrderModel orderModel = OrderModel(items: items, date: DateTime.now());
      DocumentReference doc = firestoreServices.getDocumentRef(usersCollectionKey, UserModel.getInstance().uid);

      await doc.update({UserModel.bagKey: []});
      await doc.update({
        OrderModel.ordersKey: FieldValue.arrayUnion([orderModel.toMap()])
      });
      for (var item in items) {
      DocumentReference productDoc = firestoreServices.getDocumentRef('products', item.productId);
      await productDoc.update({
        'stock': FieldValue.increment(-item.quantity) 
      });
    }
    }
  }

  @override
  Future<void> addToFavourites(String productUID) async {
    if (!UserModel.getInstance().favourites.contains(productUID)) {
      UserModel.getInstance().favourites.add(productUID);
      await favouriteRepo.addToFavourites(UserModel.getInstance().uid, productUID);
    }
  }

  @override
  Future<void> removeFromFavourites(String productUID) async {
    if (UserModel.getInstance().favourites.contains(productUID)) {
      UserModel.getInstance().favourites.remove(productUID);
      await favouriteRepo.removeFromFavourites(UserModel.getInstance().uid, productUID);
    }
  }

  @override
  Future<void> addToBag(String productUID) async {
  DocumentSnapshot productSnapshot = await firestoreServices.getDocumentRef('products', productUID).get();
  if (productSnapshot.exists) {
    int stock = productSnapshot['stock'] ?? 0;

    if (stock > 0) {
      if (!UserModel.getInstance().bag.contains(productUID)) {
        UserModel.getInstance().bag.add(productUID);
        await firestoreServices.updateField(
          usersCollectionKey,
          UserModel.getInstance().uid,
          {UserModel.bagKey: UserModel.getInstance().bag},
        );
      } 
    } else {
      throw Exception('Product is out of stock.');
    }
  } else {
    throw Exception('Product does not exist.');
  }
}

  @override
  Future<void> deleteFromBag(String productUID) async {
    if (UserModel.getInstance().bag.contains(productUID)) {
      UserModel.getInstance().bag.remove(productUID);
      await firestoreServices.updateField(usersCollectionKey, UserModel.getInstance().uid, {UserModel.bagKey: UserModel.getInstance().bag});
    }
  }

  @override
  Future<void> addReview(OrderReviewModel review) async {
    DocumentReference doc = firestoreServices.getDocumentRef(usersCollectionKey, UserModel.getInstance().uid);
    List<dynamic> orders = (await doc.get()).get(OrderModel.ordersKey);
    orders.last[OrderReviewModel.reviewKey] = review.toMap();
    await doc.update({OrderModel.ordersKey: orders});
  }
}
