import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/bag_repo.dart';
import 'package:online_shopping/Features/favourite/domain/repo_interface/favourite_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/core/models/user_model.dart';

class BagRepoImpl extends BagRepo {
  UserModel user = UserModel.getInstance();
  final FavouriteRepo favouriteRepo;

  BagRepoImpl(this.favouriteRepo);

  @override
  Future<List<ProductModel>> getMyBagItems() async {
    await getBagAndFavourites();

    List<ProductModel> products = [];

    if (user.bag!.isNotEmpty) {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection('products').where(FieldPath.documentId, whereIn: user.bag).get();
      for (int i = 0; i < result.docs.length; i++) {
        products.add(ProductModel.fromJson(result.docs[i], result.docs[i].id));
      }
    }

    return products;
  }

  @override
  Future<void> checkOut() async {
    await getBagAndFavourites();

    if (user.bag != null && user.bag!.isNotEmpty) {
      user.bag = [];
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'bag': []});
    }
  }

  @override
  Future<void> addToFavourites(String productUID) async {
    await getBagAndFavourites();

    if (!user.favourites!.contains(productUID)) {
      user.favourites!.add(productUID);
      await favouriteRepo.addToFavourites(user.uid, productUID);
    }
  }

  @override
  Future<void> removeFromFavourites(String productUID) async {
    await getBagAndFavourites();

    if (user.favourites!.contains(productUID)) {
      user.favourites!.remove(productUID);
      await favouriteRepo.removeFromFavourites(user.uid, productUID);
    }
  }

  @override
  Future<void> addToBag(String productUID) async {
    await getBagAndFavourites();

    if (!user.bag!.contains(productUID)) {
      user.bag!.add(productUID);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'bag': user.bag});
    }
  }

  @override
  Future<void> deleteFromBag(String productUID) async {
    await getBagAndFavourites();

    if (user.bag!.contains(productUID)) {
      user.bag!.remove(productUID);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'bag': user.bag});
    }
  }

  Future<void> getBagAndFavourites() async {
    if (user.bag == null) {
      user.setMyBagItems([]);
    }

    if (user.favourites == null) {
      user.setFavouritesItems([]);
    }
  }
}
