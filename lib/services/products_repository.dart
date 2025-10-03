import '../models/product.dart';

abstract class ProductsRepository {
  /// Feed (optionally filtered by top-level category like 'Women', 'Men', 'All').
  Future<List<Product>> fetchFeed({
    int limit = 20,
    String? categoryFilter,
  });

  /// Items by the same seller (identified by sellerId).
  Future<List<Product>> fetchSellerItems(
    String sellerId, {
    int limit = 20,
  });

  /// Similar items based on a category prefix (e.g., top-level category).
  Future<List<Product>> fetchSimilar(
    String categoryPath, {
    int limit = 20,
  });

  /// Toggle like for a user on a product.
  Future<void> toggleLike({
    required String productId,
    required String userId,
  });

  /// Create a new product and return its Firestore id (or a temp id in fake repo).
  Future<String> createListing(Product product);

  /// Live updates for a product.
  Stream<Product> watchProduct(
    String id, {
    String? currentUserId,
  });
}
