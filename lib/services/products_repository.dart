/*
// lib/services/products_repository.dart
import '../models/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchFeed({int limit = 20, String? categoryFilter});
  Future<List<Product>> fetchSellerItems(String sellerId, {int limit = 20});
  Future<List<Product>> fetchSimilar(String categoryPath, {int limit = 20});

  Future<void> toggleLike({
    required String productId,
    required String userId,
  });

  Future<String> createProduct(Product product);

  Stream<Product> watchProduct(String id, {String? currentUserId});
}


*/

// lib/services/products_repository.dart
import '../models/product.dart';

abstract class ProductsRepository {
  /// Home/feed items (optionally filtered by top-level category).
  Future<List<Product>> fetchFeed({
    int limit = 20,
    String? categoryFilter, // e.g. "Women", "Men", "Electronics" or "All"/null
  });

  /// Items by the same seller (by username or id; we’ll use username here)
  Future<List<Product>> fetchBySellerUsername(String username,
      {int limit = 20});

  /// “Similar” items (simple heuristic by category path).
  Future<List<Product>> fetchSimilarTo(Product base, {int limit = 20});

  /// Toggle like for current user (fake repo can just flip local state).
  Future<Product> toggleLike({
    required String productId,
    required String currentUserId,
  });

  /// Create a listing (fake repo can return a stub).
  Future<Product> createListing({
    required String title,
    required double price,
    required String categoryPath,
    String brand,
    String condition,
    String size,
    String colour,
    String description,
    List<String> images,
    required String sellerId,
    required String sellerUsername,
    String? sellerAvatarUrl,
  });
}
