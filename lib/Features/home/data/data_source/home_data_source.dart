import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

class HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSource(this.firestore);
  Future<List<ProductModel>> getProductsByCategory(
      List<String> category) async {
    final snapshot = await firestore
        .collection('products')
        .where('category', arrayContains: category)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
        .toList();
  }
  Future<List<ProductModel>> getNewestProducts() async {
    final snapshot = await firestore
        .collection('products')
        .orderBy('date', descending: true)
        .limit(10)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<ProductModel>> getProductsOnSale() async {
    final snapshot = await firestore
        .collection('products')
        .where('discount', isGreaterThan: 0)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
        .toList();
  }

}