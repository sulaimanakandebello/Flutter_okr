/*
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/fake_products_repository.dart';

class AppState extends ChangeNotifier {
  final FakeProductsRepository repo;

  AppState({required this.repo});

  final List<Product> _feed = [];
  bool _loading = false;

  List<Product> get feed => List.unmodifiable(_feed);
  bool get loading => _loading;

  Future<void> loadInitial() async {
    if (_loading || _feed.isNotEmpty) return;
    _loading = true;
    notifyListeners();

    // Fake async fetch (you can add a delay if you want)
    final items = repo.fetchFeed();
    _feed
      ..clear()
      ..addAll(items);

    _loading = false;
    notifyListeners();
  }

  void toggleLike(String productId) {
    final i = _feed.indexWhere((p) => p.id == productId);
    if (i == -1) return;
    final p = _feed[i];
    final liked = !p.likedByMe;
    _feed[i] = p.copyWith(
      likedByMe: liked,
      likes: (p.likes + (liked ? 1 : -1)).clamp(0, 1 << 31),
    );
    notifyListeners();
  }
}
*/

// lib/state/app_state.dart (excerpt)
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../data/products_repository.dart';

class AppState extends ChangeNotifier {
  final ProductsRepository repo;
  AppState({required this.repo});

  bool loading = false;
  List<Product> feed = [];

  Future<void> loadInitial() async {
    loading = true;
    notifyListeners();
    try {
      feed = await repo.fetchFeed(limit: 24);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> toggleLike(String productId, String userId) async {
    await repo.toggleLike(productId: productId, userId: userId);
    // Optimistic UI: reflect in memory
    final i = feed.indexWhere((p) => p.id == productId);
    if (i != -1) {
      final p = feed[i];
      final liked = !p.likedByMe;
      feed[i] = Product(
        id: p.id,
        title: p.title,
        brand: p.brand,
        price: p.price,
        images: p.images,
        condition: p.condition,
        size: p.size,
        colour: p.colour,
        categoryPath: p.categoryPath,
        description: p.description,
        sellerId: p.sellerId,
        sellerUsername: p.sellerUsername,
        sellerAvatarUrl: p.sellerAvatarUrl,
        badges: p.badges,
        likes: (liked ? p.likes + 1 : p.likes - 1).clamp(0, 1 << 31),
        likedByMe: liked,
        uploadedAt: p.uploadedAt,
      );
      notifyListeners();
    }
  }
}
