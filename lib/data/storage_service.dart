// lib/data/storage_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadProductImage({
    required File file,
    required String productIdOrTemp,
    required String filename,
  }) async {
    final ref =
        _storage.ref().child('product_images/$productIdOrTemp/$filename');
    final task = await ref.putFile(file);
    return await task.ref.getDownloadURL();
  }
}
