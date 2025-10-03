// lib/services/fake_products_repository.dart
import 'dart:async';

import '../models/product.dart';
import '../models/seller.dart';
import 'products_repository.dart';

class FakeProductsRepository implements ProductsRepository {
  FakeProductsRepository();

  /// In-memory dataset (acts like a tiny “database” for local/dev use).
  final List<Product> _items = <Product>[
    Product(
      id: 'p1',
      title: 'Nike Air Vintage Tee',
      brand: 'Nike',
      price: 17.00,
      images: const [
        'https://images.unsplash.com/photo-1523381294911-8d3cead13475?w=800',
      ],
      condition: 'New with tags',
      size: 'M',
      colour: 'Black',
      categoryPath: 'Men > Clothing > T-shirts',
      description:
          'Classic Nike tee in great condition. Soft cotton, true to size.',
      seller:
          const Seller(username: 'theslyman', rating: 5.0, ratingCount: 1027),
      sellerId: 'u-theslyman',
      sellerUsername: 'theslyman',
      badges: const ['Speedy Shipping'],
      likes: 17,
      likedByMe: false,
      uploadedAt: DateTime.now().subtract(const Duration(minutes: 33)),
    ),
    Product(
      id: 'p2',
      title: 'COS Wool Jumper',
      brand: 'COS',
      price: 20.00,
      images: const [
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800',
      ],
      condition: 'New without tags',
      size: 'M',
      colour: 'Grey',
      categoryPath: 'Men > Clothing > Jumpers & Sweaters',
      description: 'Minimal wool jumper, barely worn. Warm and breathable.',
      seller: const Seller(username: 'amelie', rating: 4.7, ratingCount: 209),
      sellerId: 'u-amelie',
      sellerUsername: 'amelie',
      badges: const [],
      likes: 79,
      likedByMe: false,
      uploadedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Product(
      id: 'p3',
      title: 'Levi’s 501 Straight Jeans',
      brand: 'Levi’s',
      price: 15.00,
      images: const [
        'https://images.unsplash.com/photo-1519741497674-611481863552?w=800',
      ],
      condition: 'Used - good',
      size: '32',
      colour: 'Denim Blue',
      categoryPath: 'Women > Clothing > Jeans',
      description: 'Classic 501 fit. Light fade. No rips. Great everyday pair.',
      seller: const Seller(username: 'bianca', rating: 4.9, ratingCount: 412),
      sellerId: 'u-bianca',
      sellerUsername: 'bianca',
      badges: const [],
      likes: 3,
      likedByMe: false,
      uploadedAt:
          DateTime.now().subtract(const Duration(hours: 5, minutes: 20)),
    ),
    Product(
      id: 'p4',
      title: 'Zara Puffer Jacket',
      brand: 'Zara',
      price: 12.00,
      images: const [
        'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=800',
      ],
      condition: 'Used - fair',
      size: 'M',
      colour: 'Olive',
      categoryPath: 'Designer > Clothing > Outerwear',
      description: 'Cozy puffer with light wear. Perfect for chilly walks.',
      seller: const Seller(username: 'marco', rating: 4.5, ratingCount: 98),
      sellerId: 'u-marco',
      sellerUsername: 'marco',
      badges: const [],
      likes: 9,
      likedByMe: false,
      uploadedAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
    Product(
      id: 'p5',
      title: 'Adidas Running Shoes',
      brand: 'Adidas',
      price: 28.50,
      images: const [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800',
      ],
      condition: 'Used - very good',
      size: 'US 9',
      colour: 'White',
      categoryPath: 'Men > Shoes > Sneakers',
      description: 'Lightly used, great cushioning. Clean uppers, fresh laces.',
      seller: const Seller(username: 'kofi', rating: 4.6, ratingCount: 54),
      sellerId: 'u-kofi',
      sellerUsername: 'kofi',
      badges: const ['Speedy Shipping'],
      likes: 21,
      likedByMe: false,
      uploadedAt: DateTime.now().subtract(const Duration(days: 2, hours: 7)),
    ),
    Product(
      id: 'p6',
      title: 'Uniqlo Lightweight Parka',
      brand: 'Uniqlo',
      price: 19.00,
      images: const [
        'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800',
      ],
      condition: 'Used - good',
      size: 'L',
      colour: 'Navy',
      categoryPath: 'Women > Clothing > Coats & Jackets',
      description: 'Packable parka, water repellent. Everyday essential.',
      seller: const Seller(username: 'nina', rating: 4.8, ratingCount: 330),
      sellerId: 'u-nina',
      sellerUsername: 'nina',
      badges: const [],
      likes: 12,
      likedByMe: false,
      uploadedAt: DateTime.now().subtract(const Duration(days: 3, hours: 10)),
    ),
  ];

  @override
  Future<List<Product>> fetchFeed(
      {int limit = 20, String? categoryFilter}) async {
    final list = (categoryFilter == null || categoryFilter == 'All')
        ? _items
        : _items.where((p) {
            final top = p.categoryPath.split('>').first.trim().toLowerCase();
            return top == categoryFilter.toLowerCase();
          }).toList();
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return List<Product>.from(list.take(limit));
  }

  @override
  Future<List<Product>> fetchSellerItems(String sellerId,
      {int limit = 20}) async {
    final list =
        _items.where((p) => p.sellerId == sellerId).take(limit).toList();
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return List<Product>.from(list);
  }

  @override
  Future<List<Product>> fetchSimilar(String categoryPath,
      {int limit = 20}) async {
    final top = categoryPath.split('>').first.trim().toLowerCase();
    final list = _items
        .where((p) {
          final pTop = p.categoryPath.split('>').first.trim().toLowerCase();
          return pTop == top;
        })
        .take(limit)
        .toList();
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return List<Product>.from(list);
  }

  @override
  Future<void> toggleLike(
      {required String productId, required String userId}) async {
    final idx = _items.indexWhere((p) => p.id == productId);
    if (idx == -1) return;
    final p = _items[idx];
    _items[idx] = p.copyWith(
      likedByMe: !p.likedByMe,
      likes: p.likedByMe ? (p.likes - 1).clamp(0, 1 << 31) : p.likes + 1,
    );
    await Future<void>.delayed(const Duration(milliseconds: 60));
  }

  @override
  Stream<Product> watchProduct(String id, {String? currentUserId}) async* {
    yield _items.firstWhere((e) => e.id == id, orElse: () => _items.first);
  }

  @override
  Future<String> createListing(Product product) async {
    _items.add(product);
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return product.id;
  }
}
