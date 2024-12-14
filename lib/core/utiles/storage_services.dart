import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  StorageServices();

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadFile(String filePath, String uploadPath) async {
    final Reference ref = firebaseStorage.ref(uploadPath);
    File file = File(filePath);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> deleteFile(String uploadPath) async {
    await firebaseStorage.refFromURL(uploadPath).delete();
  }
}
