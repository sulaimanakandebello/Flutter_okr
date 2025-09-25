/*
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/products_repository.dart';

class AppState extends ChangeNotifier {
  final ProductsRepository repo;
  AppState({required this.repo});

  List<Product> feed = [];
  bool loading = false;

  Future<void> loadInitial() async {
    loading = true;
    notifyListeners();
    feed = await repo.fetchFeed();
    loading = false;
    notifyListeners();
  }

  void toggleLike(String productId) {
    final i = feed.indexWhere((p) => p.id == productId);
    if (i == -1) return;
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
      seller: p.seller,
      sellerId: p.sellerId,
      sellerUsername: p.sellerUsername,
      badges: p.badges,
      likes: liked ? p.likes + 1 : (p.likes > 0 ? p.likes - 1 : 0),
      likedByMe: liked,
      uploadedAt: p.uploadedAt,
    );
    notifyListeners();
  }
}
*/

// lib/state/app_state.dart
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/products_repository.dart';

class AppState extends ChangeNotifier {
  AppState({required this.repo});

  final ProductsRepository repo;

  bool _loading = false;
  bool _initialized = false;
  List<Product> _feed = [];

  bool get loading => _loading;
  bool get initialized => _initialized;
  List<Product> get feed => List.unmodifiable(_feed);

  /// Safe initial load
  Future<void> loadInitial({String? category}) async {
    if (_initialized || _loading) return; // <- guard re-entry
    _loading = true;
    notifyListeners(); // ok: happens after first frame (see page initState below)
    try {
      final items = await repo.fetchFeed(limit: 20, categoryFilter: category);
      _feed = items;
      _initialized = true;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> refreshFeed({String? category}) async {
    if (_loading) return;
    _loading = true;
    notifyListeners();
    try {
      _feed = await repo.fetchFeed(limit: 20, categoryFilter: category);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> toggleLike(String productId,
      {required String currentUserId}) async {
    final updated = await repo.toggleLike(
        productId: productId, currentUserId: currentUserId);
    final i = _feed.indexWhere((p) => p.id == productId);
    if (i != -1) {
      _feed = [..._feed]..[i] = updated;
      notifyListeners();
    }
  }
}
