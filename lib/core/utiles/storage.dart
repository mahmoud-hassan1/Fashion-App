import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  Future<String> uploadFile(String filePath, String uploadPath) async {
    final Reference ref = FirebaseStorage.instance.ref("firstimage.jpg");
    File file = File(filePath);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> deleteFile(String uploadPath) async {
    await FirebaseStorage.instance.refFromURL(uploadPath).delete();
  }
}
