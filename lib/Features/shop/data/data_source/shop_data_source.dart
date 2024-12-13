import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

class ShopRemoteDataSource {
  final FirebaseFirestore firestore;

  ShopRemoteDataSource(this.firestore);

  Future<List<ProductModel>> getProductsByCategory(List<String> category) async {
    final snapshot = await firestore.collection('products').where('categories', arrayContainsAny: category).get();

    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<List<ProductModel>> getNewestProductsByCategory(List<String> category) async {
    final DateTime oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('categories', arrayContainsAny: category)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(oneWeekAgo))
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<List<ProductModel>> getSaleProductsByCategory(List<String> category) async {
    final snapshot = await FirebaseFirestore.instance.collection('products').where('categories', arrayContainsAny: category).where('discount', isGreaterThan: 0).get();

    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }
}
