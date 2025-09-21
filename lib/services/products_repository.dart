import '../models/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> fetchFeed({
    int page = 1,
    int pageSize = 20,
    String? category,
    String? query,
  });

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
