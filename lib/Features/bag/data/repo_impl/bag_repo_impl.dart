import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/bag/domain/repo_interface/bag_repo.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/core/models/user_model.dart';

class BagRepoImpl extends BagRepo {
  UserModel user = UserModel.getInstance();

  @override
  Future<List<ProductModel>> getMyBagItems() async {
    await getBagAndFavourites();

    List<ProductModel> products = [];

    if (user.bag!.isNotEmpty) {
      final QuerySnapshot result = await FirebaseFirestore.instance.collection('products').where(FieldPath.documentId, whereIn: user.bag).get();
      for (int i = 0; i < result.docs.length; i++) {
        products.add(ProductModel.fromJson(result.docs[i], user.bag![i]));
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
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'favourites': user.favourites});
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
      final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      user.setMyBagItems(doc.get('bag'));
    }

    if (user.favourites == null) {
      final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      user.setFavouritesItems(doc.get('favourites'));
    }
  }
}
