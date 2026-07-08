import 'dart:io';
import 'package:online_shopping/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageServices {
  SupabaseStorageServices();

  final SupabaseClient supabaseStorage = Supabase.instance.client;

  Future<String> uploadFile(String filePath, String uploadPath) async {
    await supabaseStorage.storage.from(productsSupabaseBucketName).upload(
          uploadPath,
          File(filePath),
          fileOptions: const FileOptions(upsert: true),
        );

    final String imageUrl = supabaseStorage.storage
        .from(productsSupabaseBucketName)
        .getPublicUrl(uploadPath);

    return imageUrl;
  }

  Future<void> deleteFile(String uploadPath) async {
    await supabaseStorage.storage
        .from(productsSupabaseBucketName)
        .remove([uploadPath]);
  }
}
