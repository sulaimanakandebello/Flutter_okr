/*
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
        productId: productId, userId: currentUserId);
    final i = _feed.indexWhere((p) => p.id == productId);
    if (i != -1) {
      _feed = [..._feed]..[i] = updated;
      notifyListeners();
    }
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
    if (_initialized || _loading) return; // guard re-entry
    _loading = true;
    notifyListeners(); // safe: call from a post-frame callback in UI
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

  /// Optimistic like toggle: update UI immediately, then confirm with repo.
  Future<void> toggleLike(
    String productId, {
    required String currentUserId,
  }) async {
    final i = _feed.indexWhere((p) => p.id == productId);
    if (i == -1) return;

    final old = _feed[i];
    final wasLiked = old.likedByMe;
    final newLikes =
        wasLiked ? (old.likes - 1).clamp(0, 1 << 31) : old.likes + 1;
    final optimistic = old.copyWith(likedByMe: !wasLiked, likes: newLikes);

    // Apply optimistic update
    _feed = [..._feed]..[i] = optimistic;
    notifyListeners();

    try {
      // Repo returns void; it just persists the change
      await repo.toggleLike(productId: productId, userId: currentUserId);
    } catch (e) {
      // Revert on failure
      _feed = [..._feed]..[i] = old;
      notifyListeners();
      rethrow;
    }
  }
}
