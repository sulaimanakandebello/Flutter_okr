/*
import '../models/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchFeed({
    int page = 1,
    int pageSize = 20,
    String? category,
    String? query,
  });

  Future<List<Product>> fetchBySeller(String username);
  Future<List<Product>> fetchSimilar(Product base);

  Future<Product> toggleLike(String productId);

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
  });
}
*/

/*

import '../models/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchFeed({
    int page = 1,
    int pageSize = 20,
    String? category,
    String? query,
  });

  Future<List<Product>> fetchBySeller(String username);
  Future<List<Product>> fetchSimilar(Product base);

  Future<Product> toggleLike(String productId);

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
  });
}
*/

/*
import '../models/product.dart';

/// Unified repository contract used by both FirebaseProductsRepository
/// and FakeProductsRepository.
abstract class ProductsRepository {
  /// Home feed (optionally filtered).
  Future<List<Product>> fetchFeed({int limit = 20, String? categoryFilter});

  /// Items by seller (use sellerId for Firebase; fake repo also stores sellerId).
  Future<List<Product>> fetchSellerItems(String sellerId, {int limit = 20});

  /// Very basic similarity (same top-level category prefix).
  Future<List<Product>> fetchSimilar(String categoryPath, {int limit = 20});

  /// Toggle like for a product by a given user.
  Future<void> toggleLike({
    required String productId,
    required String userId,
  });

  /// Create a listing and return its generated id.
  Future<String> createListing(Product product);

  /// Real-time updates for a single product.
  Stream<Product> watchProduct(String id, {String? currentUserId});
}
*/

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
