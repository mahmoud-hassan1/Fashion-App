import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

class FavouritesDataSource {
  final FirebaseFirestore firestore;

  FavouritesDataSource(this.firestore);

  Future<List<ProductModel>> getProductsById() async {
    final snapshot = await firestore
        .collection('products')
        .where(FieldPath.documentId, whereIn: ['aGMNOyRFPhysPwPIut00',"mKJFiOPSqUGCcQ6AU8ZV"])
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  
}