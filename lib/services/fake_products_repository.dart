/*
// lib/services/fake_products_repository.dart
import 'package:flutter_okr/models/seller.dart';

import '../models/product.dart';
import '/services/products_repository.dart';

/// In-memory demo repo. Safe to use while wiring UI.
class FakeProductsRepository implements ProductsRepository {
  const FakeProductsRepository();

  List<Product> _seed() {
    final now = DateTime.now();
    return [
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
        seller: const Seller(
            username: 'theslyman',
            rating: 5.0,
            ratingCount: 1027,
            avatarUrl: null),
        sellerId: 'u-theslyman',
        sellerUsername: 'theslyman',
        badges: const ['Speedy Shipping'],
        likes: 17,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(minutes: 33)),
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
        uploadedAt: now.subtract(const Duration(hours: 2)),
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
        description:
            'Classic 501 fit. Light fade. No rips. Great everyday pair.',
        seller: const Seller(username: 'bianca', rating: 4.9, ratingCount: 412),
        sellerId: 'u-bianca',
        sellerUsername: 'bianca',
        badges: const [],
        likes: 3,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(hours: 5, minutes: 20)),
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
        uploadedAt: now.subtract(const Duration(days: 1, hours: 3)),
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
        description:
            'Lightly used, great cushioning. Clean uppers, fresh laces.',
        seller: const Seller(username: 'kofi', rating: 4.6, ratingCount: 54),
        sellerId: 'u-kofi',
        sellerUsername: 'kofi',
        badges: const ['Speedy Shipping'],
        likes: 21,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 2, hours: 7)),
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
        uploadedAt: now.subtract(const Duration(days: 3, hours: 10)),
      ),
      Product(
        id: 'p7',
        title: 'Apple AirPods Pro (2nd gen)',
        brand: 'Apple',
        price: 145.00,
        images: const [
          'https://images.unsplash.com/photo-1585386959984-a41552231659?w=800',
        ],
        condition: 'Used - like new',
        size: '—',
        colour: 'White',
        categoryPath: 'Electronics > Audio > Headphones',
        description: 'Barely used. Includes case and extra ear tips.',
        seller:
            const Seller(username: 'techtony', rating: 4.4, ratingCount: 76),
        sellerId: 'u-techtony',
        sellerUsername: 'techtony',
        badges: const [],
        likes: 63,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 4, hours: 1)),
      ),
      Product(
        id: 'p8',
        title: 'H&M Cotton Shirt Dress',
        brand: 'H&M',
        price: 11.00,
        images: const [
          'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=800',
        ],
        condition: 'Used - good',
        size: 'S',
        colour: 'Beige',
        categoryPath: 'Women > Clothing > Dresses',
        description:
            'Easy throw-on dress. Breathable cotton. Great for summer.',
        seller: const Seller(username: 'lina', rating: 4.2, ratingCount: 35),
        sellerId: 'u-lina',
        sellerUsername: 'lina',
        badges: const [],
        likes: 8,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 5, hours: 12)),
      ),
    ];
  }

  @override
  Future<List<Product>> fetchFeed(
      {int limit = 20, String? categoryFilter}) async {
    final all = _seed();
    if (categoryFilter == null ||
        categoryFilter.isEmpty ||
        categoryFilter == 'All') {
      return all.take(limit).toList();
    }
    final top = categoryFilter.trim();
    final filtered = all
        .where((p) => p.categoryPath.split('>').first.trim() == top)
        .toList();
    return filtered.take(limit).toList();
  }

  @override
  Future<List<Product>> fetchBySellerUsername(String username,
      {int limit = 20}) async {
    final all = _seed();
    return all.where((p) => p.sellerUsername == username).take(limit).toList();
  }

  @override
  Future<List<Product>> fetchSimilarTo(Product base, {int limit = 20}) async {
    final all = _seed();
    final top = base.categoryPath.split('>').first.trim();
    return all
        .where((p) =>
            p.id != base.id && p.categoryPath.split('>').first.trim() == top)
        .take(limit)
        .toList();
  }

  @override
Future<void> toggleLike({
  required String productId,
  required String userId, // <- name + presence must match interface
}) async {
  final idx = _items.indexWhere((p) => p.id == productId);
  if (idx == -1) return;

  final p = _items[idx];
  final wasLiked = p.likedByMe;
  final newLikes = wasLiked ? (p.likes - 1).clamp(0, 1 << 31) : p.likes + 1;

  _items[idx] = p.copyWith(
    likedByMe: !wasLiked,
    likes: newLikes,
  );

*/

/*
  // simulate async
  await Future<void>.delayed(const Duration(milliseconds: 150));
}

  @override
  Future<Product> toggleLike(
      {required String productId, required String userId}) async {
    // In-memory demo: flip likedByMe and +/-1 likes on the fly.
    final all = _seed();
    final idx = all.indexWhere((p) => p.id == productId);
    if (idx < 0) throw StateError('Product not found: $productId');
    final p = all[idx];
    final liked = !p.likedByMe;
    final updated = p.copyWith(
      likedByMe: liked,
      likes: (liked ? p.likes + 1 : (p.likes - 1).clamp(0, 1 << 31)),
    );
    return updated;
  }

  @override
  Future<Product> createListing({
    required String title,
    required double price,
    required String categoryPath,
    String brand = '',
    String condition = '',
    String size = '',
    String colour = '',
    String description = '',
    List<String> images = const [],
    required String sellerId,
    required String sellerUsername,
    String? sellerAvatarUrl,
  }) async {
    final now = DateTime.now();
    return Product(
      id: 'new-${now.millisecondsSinceEpoch}',
      title: title,
      brand: brand,
      price: price,
      images: images,
      condition: condition,
      size: size,
      colour: colour,
      categoryPath: categoryPath,
      description: description,
      seller: Seller(
        username: sellerUsername,
        rating: 5,
        ratingCount: 1,
        avatarUrl: sellerAvatarUrl,
      ),
      sellerId: sellerId,
      sellerUsername: sellerUsername,
      badges: const [],
      likes: 0,
      likedByMe: false,
      uploadedAt: now,
    );
  }*/

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

    // Simulate I/O
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
  Future<void> toggleLike({
    required String productId,
    required String userId, // kept for parity with real repo; not used here
  }) async {
    final idx = _items.indexWhere((p) => p.id == productId);
    if (idx == -1) return;

    final p = _items[idx];
    final wasLiked = p.likedByMe;
    final newLikes = wasLiked ? (p.likes - 1).clamp(0, 1 << 31) : p.likes + 1;

    _items[idx] = p.copyWith(likedByMe: !wasLiked, likes: newLikes);

    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  @override
  Stream<Product> watchProduct(String id, {String? currentUserId}) async* {
    // Simple one-shot “watch” so callers have a Stream to listen to.
    final p = _items.firstWhere((e) => e.id == id, orElse: () => _items.first);
    yield p;
  }

  @override
  Future<String> createListing(Product product) async {
    _items.add(product);
    await Future<void>.delayed(const Duration(milliseconds: 80));
    return product.id;
  }
}
