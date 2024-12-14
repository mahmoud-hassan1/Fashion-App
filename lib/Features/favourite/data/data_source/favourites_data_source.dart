import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/models/user_model.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';

class FavouritesDataSource {
  FavouritesDataSource(this.firestoreServices);

  final FirestoreServices firestoreServices;
  UserModel user = UserModel.getInstance();

  Future<List<ProductModel>> getProductsById() async {
    final snapshot = await firestoreServices.getCollectionRef(productsCollectionKey).where(FieldPath.documentId, whereIn: user.favourites).get();
    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<void> addToFavourites(String userId, String productId) async {
    await firestoreServices.updateField(usersCollectionKey, userId, {
      UserModel.favouritesKey: FieldValue.arrayUnion([productId])
    });
  }

  Future<void> removeFromFavourites(String userId, String productId) async {
    await firestoreServices.updateField(usersCollectionKey, userId, {
      UserModel.favouritesKey: FieldValue.arrayRemove([productId])
    });
  }
}
