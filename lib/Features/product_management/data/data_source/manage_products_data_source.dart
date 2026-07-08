import 'dart:io';
import 'package:online_shopping/Features/home/data/models/product_model.dart';
import 'package:online_shopping/constants.dart';
import 'package:online_shopping/core/utiles/firebase_firestore_services.dart';
import 'package:online_shopping/core/utiles/supabase_storage_services.dart';

class ManageProductsDataSource {
  final FirestoreServices firestoreServices;
  // final FirebaseStorageServices firebaseStorageServices;
  final SupabaseStorageServices supabaseStorageServices;

  const ManageProductsDataSource(
    this.firestoreServices,
    this.supabaseStorageServices,
    // this.firebaseStorageServices,
  );

  Future<List<String>> _uploadImages(List<File> selectedImages) async {
    List<String> downloadUrls = [];
    for (File image in selectedImages) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String downloadUrl = await supabaseStorageServices.uploadFile(
        productsSupabaseBucketName,
        image.path,
        'products/$fileName',
      );
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

    await firestoreServices.setDocument(
      productsCollectionKey,
      product.toJson(),
    );
  }

  Future<void> editProduct(
    ProductModel product,
    List<File> selectedImages,
  ) async {
    List<String> imageUrls = await _uploadImages(selectedImages);
    product.images = imageUrls;
    product.image = imageUrls[0];

    await firestoreServices.updateField(
      productsCollectionKey,
      product.id,
      product.toJson(),
    );
  }

  Future<void> deleteProduct(ProductModel product) async {
    await firestoreServices.deleteDoc(productsCollectionKey, product.id);
  }
}
