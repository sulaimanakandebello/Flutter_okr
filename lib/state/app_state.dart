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

  /// Safe initial load (guards against re-entry)
  Future<void> loadInitial({String? category}) async {
    if (_initialized || _loading) return;
    _loading = true;
    notifyListeners();
    try {
      _feed = await repo.fetchFeed(limit: 20, categoryFilter: category);
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

  /// Toggle like in the backend and update local feed item if present.
  Future<void> toggleLike(String productId, {required String userId}) async {
    await repo.toggleLike(productId: productId, userId: userId);

    // Optimistically mirror the change in the in-memory feed if item is there.
    final i = _feed.indexWhere((p) => p.id == productId);
    if (i != -1) {
      final p = _feed[i];
      final nextLiked = !p.likedByMe;
      final nextLikes =
          nextLiked ? (p.likes + 1) : (p.likes - 1).clamp(0, 1 << 31);
      _feed = [..._feed]..[i] =
          p.copyWith(likedByMe: nextLiked, likes: nextLikes);
      notifyListeners();
    }
  }

  /// 🔴 NEW: Stream a single product (Firebase repo emits live snapshots;
  /// Fake repo can emit a one-shot value).
  Stream<Product> watchProduct(String id, {String? currentUserId}) {
    return repo.watchProduct(id, currentUserId: currentUserId);
  }
}
