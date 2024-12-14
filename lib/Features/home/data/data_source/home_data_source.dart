import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';

class HomeRemoteDataSource {
  final FirestoreServices firestoreServices;

  const HomeRemoteDataSource(this.firestoreServices);

  Future<List<ProductModel>> getNewestProducts() async {
    final DateTime oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    final snapshot = await firestoreServices
        .getCollectionRef(productsCollectionKey)
        .where(ProductModel.dateKey, isGreaterThanOrEqualTo: Timestamp.fromDate(oneWeekAgo))
        .orderBy(ProductModel.dateKey, descending: true)
        .get();

    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<List<ProductModel>> getProductsOnSale() async {
    final snapshot = await firestoreServices.getCollectionRef(productsCollectionKey).where(ProductModel.discountKey, isGreaterThan: 0).get();
    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }
}
