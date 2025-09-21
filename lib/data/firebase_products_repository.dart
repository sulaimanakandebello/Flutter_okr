// lib/data/firebase_products_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product.dart';
import 'products_repository.dart';

class FirebaseProductsRepository implements ProductsRepository {
  final _db = FirebaseFirestore.instance;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('products');

  @override
  Future<List<Product>> fetchFeed(
      {int limit = 20, String? categoryFilter}) async {
    Query<Map<String, dynamic>> q =
        _col.orderBy('uploadedAt', descending: true).limit(limit);
    if (categoryFilter != null &&
        categoryFilter.trim().isNotEmpty &&
        categoryFilter != 'All') {
      q = q
          .where('categoryPath', isGreaterThanOrEqualTo: categoryFilter)
          .where('categoryPath', isLessThan: '$categoryFilter\uf8ff');
    }
    final snap = await q.get();
    return snap.docs
        .map((d) => Product.fromFirestore(d, currentUserId: _uid))
        .toList();
  }

  @override
  Future<List<Product>> fetchSellerItems(String sellerId,
      {int limit = 20}) async {
    final snap = await _col
        .where('sellerId', isEqualTo: sellerId)
        .orderBy('uploadedAt', descending: true)
        .limit(limit)
        .get();
    return snap.docs
        .map((d) => Product.fromFirestore(d, currentUserId: _uid))
        .toList();
  }

  @override
  Future<List<Product>> fetchSimilar(String categoryPath,
      {int limit = 20}) async {
    final prefix = categoryPath.split(' > ').first; // simple heuristic
    final snap = await _col
        .where('categoryPath', isGreaterThanOrEqualTo: prefix)
        .where('categoryPath', isLessThan: '$prefix\uf8ff')
        .orderBy('uploadedAt', descending: true)
        .limit(limit)
        .get();
    return snap.docs
        .map((d) => Product.fromFirestore(d, currentUserId: _uid))
        .toList();
  }

  @override
  Future<void> toggleLike(
      {required String productId, required String userId}) async {
    final ref = _col.doc(productId);
    await _db.runTransaction((tx) async {
      final snap = await tx.get(ref);
      if (!snap.exists) return;
      final data = snap.data()!;
      final likedBy = Map<String, dynamic>.from(data['likedBy'] ?? {});
      final likesCount = (data['likesCount'] ?? 0) as int;

      final already = likedBy[userId] == true;
      if (already) {
        likedBy.remove(userId);
        tx.update(ref, {
          'likedBy': likedBy,
          'likesCount': (likesCount - 1).clamp(0, 1 << 31),
        });
      } else {
        likedBy[userId] = true;
        tx.update(ref, {
          'likedBy': likedBy,
          'likesCount': likesCount + 1,
        });
      }
    });
  }

  @override
  Future<String> createProduct(Product product) async {
    final ref = await _col.add(product.toMap());
    return ref.id;
  }

  @override
  Stream<Product> watchProduct(String id, {String? currentUserId}) {
    final uid = currentUserId ?? _uid;
    return _col.doc(id).snapshots().map((d) => Product.fromFirestore(
          d,
          currentUserId: uid,
        ));
  }
}
