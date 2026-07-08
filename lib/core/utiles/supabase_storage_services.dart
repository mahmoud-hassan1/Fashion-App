import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageServices {
  SupabaseStorageServices();

  final SupabaseClient supabaseStorage = Supabase.instance.client;

  Future<String> uploadFile(
      String bucketName, String filePath, String uploadPath) async {
    await supabaseStorage.storage.from(bucketName).upload(
          uploadPath,
          File(filePath),
          fileOptions: const FileOptions(upsert: true),
        );

    final String imageUrl =
        supabaseStorage.storage.from(bucketName).getPublicUrl(uploadPath);

    return imageUrl;
  }

  Future<void> deleteFile(String bucketName, String uploadPath) async {
    await supabaseStorage.storage.from(bucketName).remove([uploadPath]);
  }
}
