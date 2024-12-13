import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';

class HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSource(this.firestore);

  Future<List<ProductModel>> getNewestProducts() async {
    final DateTime oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    final snapshot = await firestore.collection('products').where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(oneWeekAgo)).orderBy('date', descending: true).get();

    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<List<ProductModel>> getProductsOnSale() async {
    final snapshot = await firestore.collection('products').where('discount', isGreaterThan: 0).get();

    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }
}
