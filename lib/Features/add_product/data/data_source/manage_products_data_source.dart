import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/core/widgets/snackbar.dart';

class ManageProductsDataSource {
  final FirebaseFirestore _firestore;
  ManageProductsDataSource({required FirebaseFirestore firestore})
      : _firestore = firestore;
  Future<List<String>> _uploadImages(selectedImages) async {
    List<String> downloadUrls = [];
    for (var image in selectedImages) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref =
          FirebaseStorage.instance.ref().child('products/$fileName');
      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  Future<void> uploadProduct({
    required ProductModel product,
    required List<File> selectedImages,
  }) async {
      List<String> imageUrls = await _uploadImages(selectedImages);

      product.images = imageUrls;
      product.image = imageUrls[0];

      DocumentReference docRef =
          await _firestore.collection('products').add(product.toJson());

      await docRef.update({'id': docRef.id});

  }
}
