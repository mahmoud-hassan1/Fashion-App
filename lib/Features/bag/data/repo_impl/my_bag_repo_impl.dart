import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/bag/data/models/order_item_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_model.dart';
import 'package:online_shopping/Features/bag/data/models/order_review_model.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/my_bag_repo.dart';
import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/core/models/user_model.dart';

class MyBagRepoImpl extends MyBagRepo {
  UserModel user = UserModel.getInstance();
  final FavouriteRepo favouriteRepo;

  MyBagRepoImpl(this.favouriteRepo);

  @override
  Future<List<ProductModel>> getMyBagItems() async {
    List<ProductModel> products = [];

    if (user.bag.isNotEmpty) {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection('products').where(FieldPath.documentId, whereIn: user.bag).get();
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
      DocumentReference doc = FirebaseFirestore.instance.collection('users').doc(user.uid);

      await doc.update({'bag': []});
      await doc.update({
        'orders': FieldValue.arrayUnion([orderModel.toMap()])
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
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'bag': user.bag});
    }
  }

  @override
  Future<void> deleteFromBag(String productUID) async {
    if (user.bag.contains(productUID)) {
      user.bag.remove(productUID);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'bag': user.bag});
    }
  }

  @override
  Future<void> addReview(OrderReviewModel review) async {
    DocumentReference doc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    List<dynamic> orders = (await doc.get()).get('orders');
    orders.last['review'] = review.toMap();
    await doc.update({'orders': orders});
  }
}
