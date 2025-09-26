// lib/services/storage_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  /// Upload photos to: /products/{uid}/uploads/{millis}_{index}.jpg
  /// Returns public download URLs.
  Future<List<String>> uploadProductImages({
    required String uid,
    required List<XFile> files,
  }) async {
    final List<String> urls = [];
    final millis = DateTime.now().millisecondsSinceEpoch;

    for (var i = 0; i < files.length; i++) {
      final f = files[i];

      // Some platforms give us only a path; ensure File(..) exists.
      final file = File(f.path);
      final ref = _storage
          .ref()
          .child('products')
          .child(uid)
          .child('uploads')
          .child('${millis}_$i.jpg');

      final task = await ref.putFile(file);
      final url = await task.ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }
}
