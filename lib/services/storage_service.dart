// lib/services/storage_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload product images to: products/{uid}/{folderId}/{uniqueFileName}
  ///
  /// `folderId` can be the final productId (if you have it), or a draft id.
  Future<List<String>> uploadProductImages({
    required String uid,
    required String folderId,
    required List<XFile> files,
  }) async {
    final urls = <String>[];

    for (var i = 0; i < files.length; i++) {
      final x = files[i];
      final file = File(x.path);

      // Keep the original extension if possible
      final ext = p.extension(x.path).toLowerCase();
      final uniqueName =
          'img_${i}_${DateTime.now().millisecondsSinceEpoch}${ext.isEmpty ? ".jpg" : ext}';

      final ref = _storage.ref('products/$uid/$folderId/$uniqueName');

      final metadata = SettableMetadata(
        contentType: _contentTypeFor(ext),
        cacheControl: 'public,max-age=31536000',
      );

      // 1) Upload
      final snap = await ref.putFile(file, metadata);

      // 2) Only after upload finishes, ask for URL
      final url = await snap.ref.getDownloadURL();
      urls.add(url);
    }

    return urls;
  }

  String _contentTypeFor(String ext) {
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.heic':
        return 'image/heic';
      default:
        return 'application/octet-stream';
    }
  }
}
