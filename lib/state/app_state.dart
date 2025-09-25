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
