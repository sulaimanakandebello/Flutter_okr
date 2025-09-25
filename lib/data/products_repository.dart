/*
// lib/data/products_repository.dart
import '../models/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchFeed({int limit = 20, String? categoryFilter});
  Future<List<Product>> fetchSellerItems(String sellerId, {int limit = 20});
  Future<List<Product>> fetchSimilar(String categoryPath, {int limit = 20});
  Future<void> toggleLike({required String productId, required String userId});
  Future<String> createProduct(Product product); // returns new doc id
  Stream<Product> watchProduct(String id, {String? currentUserId});
}
*/

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

  /// Create a new product listing and return its Firestore id (or a temp id).
  Future<String> createListing(Product product);

  Stream<Product> watchProduct(String id, {String? currentUserId});
}
*/
