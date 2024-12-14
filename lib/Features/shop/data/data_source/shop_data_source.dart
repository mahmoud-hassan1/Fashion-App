import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';

class ShopRemoteDataSource {
  final FirestoreServices firestoreServices;

  const ShopRemoteDataSource(this.firestoreServices);

  Future<List<ProductModel>> getProductsByCategory(List<String> category) async {
    final QuerySnapshot snapshot = await firestoreServices.getCollectionRef(productsCollectionKey).where(ProductModel.categoriesKey, arrayContainsAny: category).get();
    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<List<ProductModel>> getNewestProductsByCategory(List<String> category) async {
    final DateTime oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    final snapshot = await FirebaseFirestore.instance
        .collection(productsCollectionKey)
        .where(ProductModel.categoriesKey, arrayContainsAny: category)
        .where(ProductModel.dateKey, isGreaterThanOrEqualTo: Timestamp.fromDate(oneWeekAgo))
        .orderBy(ProductModel.dateKey, descending: true)
        .get();

    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<List<ProductModel>> getSaleProductsByCategory(List<String> category) async {
    final QuerySnapshot snapshot =
        await firestoreServices.getCollectionRef(productsCollectionKey).where(ProductModel.categoriesKey, arrayContainsAny: category).where(ProductModel.discountKey, isGreaterThan: 0).get();
    return snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();
  }
}
