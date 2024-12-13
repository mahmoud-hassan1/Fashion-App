import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/core/models/user_model.dart';

class FavouritesDataSource {
  final FirebaseFirestore firestore;

  FavouritesDataSource(this.firestore);

  Future<List<ProductModel>> getProductsById() async {
    final snapshot = await firestore.collection('products').where(FieldPath.documentId, whereIn: UserModel.getInstance().favourites).get();

    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<void> addToFavourites(String userId, String productId) async {
    await firestore.collection('users').doc(userId).update({
      'favourites': FieldValue.arrayUnion([productId])
    });
  }

  Future<void> removeFromFavourites(String userId, String productId) async {
    await firestore.collection('users').doc(userId).update({
      'favourites': FieldValue.arrayRemove([productId])
    });
  }
}
