import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/Features/home/domain/entities/product_entity.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';
import 'package:online_shopping/features/search/domain/repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final FirestoreServices fireStoreServices;

  const SearchRepoImpl(this.fireStoreServices);

  @override
  Future<List<Product>> getSearchResult(String search) async {
    if (search.trim().isEmpty) {
      return [];
    }

    try {
      search = search.trim();

      final QuerySnapshot snapshot =
          await fireStoreServices.getCollectionRef(productsCollectionKey).where('name', isGreaterThanOrEqualTo: search).where('name', isLessThanOrEqualTo: '$search\uf8ff').get();
      final List<ProductModel> products = snapshot.docs.map((doc) => ProductModel.fromJson(doc.data(), doc.id)).toList();

      return products.map((model) => model.toEntity()).toList();
    } catch (e) {
      debugPrint("Failed to get search results: ${e.toString()}");
      return [];
    }
  }

  @override
  Future<ScanResult> scanQRCode() async {
    return await BarcodeScanner.scan();
  }
}
