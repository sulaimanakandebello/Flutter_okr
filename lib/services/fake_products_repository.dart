/*
// lib/services/fake_products_repository.dart
import '../models/product.dart';
import '../models/seller.dart';

/// A simple in-memory repository that returns a demo product feed.
/// Replace with a real API/service later.
class FakeProductsRepository {
  const FakeProductsRepository();

  /// Main home feed
  List<Product> fetchFeed() {
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
          // avatarUrl: 'https://example.com/avatars/slyman.png',
        ),
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
        seller: const Seller(
          username: 'techtony',
          rating: 4.4,
          ratingCount: 76,
        ),
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

  /// Items by the same seller
  List<Product> fetchBySeller(String username) {
    return fetchFeed().where((p) => p.seller.username == username).toList();
  }

  /// Very basic "similar": same top-level category
  List<Product> fetchSimilar(Product base) {
    final top = base.categoryPath.split('>').first.trim();
    return fetchFeed().where((p) {
      final pTop = p.categoryPath.split('>').first.trim();
      return p.id != base.id && pTop == top;
    }).toList();
  }
}
*/

/*

import '../models/product.dart';
import 'products_repository.dart';
import '../models/seller.dart';


/// A simple in-memory repository that returns a demo product feed.
/// Replace with a real API/service later.
class FakeProductsRepository implements ProductsRepository {
  const FakeProductsRepository();

  @override
  Future<List<Product>> fetchFeed() async {
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
        ),
        badges: const ['Speedy Shipping'],
        likes: 17,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(minutes: 33)),
        sellerId: 'u-theslyman',
        sellerUsername: 'theslyman',
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
        badges: const [],
        likes: 79,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(hours: 2)),
        sellerId: 'u-amelie',
        sellerUsername: 'amelie',
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
        badges: const [],
        likes: 3,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(hours: 5, minutes: 20)),
        sellerId: 'u-bianca',
        sellerUsername: 'bianca',
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
        badges: const [],
        likes: 9,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 1, hours: 3)),
        sellerId: 'u-marco',
        sellerUsername: 'marco',
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
        badges: const ['Speedy Shipping'],
        likes: 21,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 2, hours: 7)),
        sellerId: 'u-kofi',
        sellerUsername: 'kofi',
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
        badges: const [],
        likes: 12,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 3, hours: 10)),
        sellerId: 'u-nina',
        sellerUsername: 'nina',
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
        seller: const Seller(
          username: 'techtony',
          rating: 4.4,
          ratingCount: 76,
        ),
        badges: const [],
        likes: 63,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 4, hours: 1)),
        sellerId: 'u-techtony',
        sellerUsername: 'techtony',
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
        badges: const [],
        likes: 8,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 5, hours: 12)),
        sellerId: 'u-lina',
        sellerUsername: 'lina',
      ),
    ];
  }

  @override
  Future<List<Product>> fetchBySeller(String username) async {
    final all = await fetchFeed();
    return all.where((p) => p.sellerUsername == username).toList();
  }

  @override
  Future<List<Product>> fetchSimilar(Product base) async {
    final all = await fetchFeed();
    final top = base.categoryPath.split('>').first.trim();
    return all.where((p) {
      final pTop = p.categoryPath.split('>').first.trim();
      return p.id != base.id && pTop == top;
    }).toList();
  }
  
  @override
  Future<Product> createListing({required String title, required double price, required String categoryPath, String brand, String condition, String size, String colour, String description, List<String> images}) {
    // TODO: implement createListing
    throw UnimplementedError();
  }
  
  @override
  Future<Product> toggleLike(String productId) {
    // TODO: implement toggleLike
    throw UnimplementedError();
  }
}
*/
/*
// lib/services/fake_products_repository.dart
import 'dart:async';

import '../models/product.dart';
import 'products_repository.dart';

/// A simple in-memory repository that mimics a backend.
/// Useful for local development before wiring Firebase.
class FakeProductsRepository implements ProductsRepository {
  FakeProductsRepository() {
    _items = _buildDemo();
    for (final p in _items) {
      _controllers[p.id] = StreamController<Product>.broadcast();
    }
  }

  late List<Product> _items;
  final Map<String, StreamController<Product>> _controllers = {};
  final Map<String, Set<String>> _likedBy = {}; // productId -> userIds

  // ---------- Helpers ----------

  int _indexOf(String id) => _items.indexWhere((p) => p.id == id);

  void _emit(Product p) {
    final i = _indexOf(p.id);
    if (i != -1) _items[i] = p;
    _controllers[p.id]?.add(p);
  }

  // ---------- Repository contract ----------

  @override
  Future<List<Product>> fetchFeed({int limit = 20, String? categoryFilter}) async {
    Iterable<Product> list = _items
        .toList()
        ..sort((a, b) => b.uploadedAt.compareTo(a.uploadedAt)); // newest first

    if (categoryFilter != null &&
        categoryFilter.trim().isNotEmpty &&
        categoryFilter != 'All') {
      final cf = categoryFilter.trim().toLowerCase();
      list = list.where((p) => p.categoryPath.toLowerCase().contains(cf));
    }

    return list.take(limit).toList();
  }

  @override
  Future<List<Product>> fetchSellerItems(String sellerId, {int limit = 20}) async {
    final items = _items.where((p) => p.sellerId == sellerId).take(limit).toList();
    return items;
  }

  @override
  Future<List<Product>> fetchSimilar(String categoryPath, {int limit = 20}) async {
    final top = categoryPath.split('>').first.trim().toLowerCase();
    final items = _items.where((p) {
      final pTop = p.categoryPath.split('>').first.trim().toLowerCase();
      return pTop == top;
    }).take(limit).toList();
    return items;
  }

  @override
  Future<void> toggleLike({
    required String productId,
    required String userId,
  }) async {
    final i = _indexOf(productId);
    if (i == -1) return;

    final likedSet = _likedBy.putIfAbsent(productId, () => <String>{});
    final already = likedSet.contains(userId);

    if (already) {
      likedSet.remove(userId);
    } else {
      likedSet.add(userId);
    }

    final p = _items[i];
    final newLikes = already ? (p.likes - 1).clamp(0, 1 << 31) : p.likes + 1;

    final updated = p.copyWith(
      likes: newLikes,
      likedByMe: !already,
    );

    _emit(updated);
  }

  @override
  Future<String> createListing(Product product) async {
    // Generate a simple id for the fake repo
    final newId = 'p${_items.length + 1}';
    final withId = product.copyWith(id: newId, uploadedAt: DateTime.now());
    _items.insert(0, withId);

    _controllers[newId] = StreamController<Product>.broadcast();
    _emit(withId);

    return newId;
  }

  @override
  Stream<Product> watchProduct(String id, {String? currentUserId}) {
    final i = _indexOf(id);
    if (i == -1) {
      // If not found, return a stream that never emits (or you could throw).
      return const Stream.empty();
    }
    final controller = _controllers[id]!;
    // Immediately push current state to new listeners.
    // (Use a microtask to avoid synchronous re-entrancy issues.)
    scheduleMicrotask(() => controller.add(_items[i]));
    return controller.stream;
  }

  // ---------- Demo Data ----------

  List<Product> _buildDemo() {
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
        description: 'Classic Nike tee in great condition. Soft cotton, true to size.',
        likes: 17,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(minutes: 33)),
        sellerId: 'u1',
        sellerUsername: 'theslyman',
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
        likes: 79,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(hours: 2)),
        sellerId: 'u2',
        sellerUsername: 'amelie',
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
        likes: 3,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(hours: 5, minutes: 20)),
        sellerId: 'u3',
        sellerUsername: 'bianca',
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
        likes: 9,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 1, hours: 3)),
        sellerId: 'u4',
        sellerUsername: 'marco',
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
        likes: 21,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 2, hours: 7)),
        sellerId: 'u5',
        sellerUsername: 'kofi',
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
        likes: 12,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 3, hours: 10)),
        sellerId: 'u6',
        sellerUsername: 'nina',
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
        likes: 63,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 4, hours: 1)),
        sellerId: 'u7',
        sellerUsername: 'techtony',
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
        description: 'Easy throw-on dress. Breathable cotton. Great for summer.',
        likes: 8,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 5, hours: 12)),
        sellerId: 'u8',
        sellerUsername: 'lina',
      ),
    ];
  }
}

*/

// lib/services/fake_products_repository.dart
import 'dart:async';

import '../models/product.dart';
import '../models/seller.dart';
import 'products_repository.dart';

/// In-memory demo implementation of [ProductsRepository].
/// Use this while wiring up UI; swap to your Firebase repo later.
class FakeProductsRepository implements ProductsRepository {
  FakeProductsRepository() {
    _items = _buildDemo();
    for (final p in _items) {
      _controllers[p.id] = StreamController<Product>.broadcast();
    }
  }

  late List<Product> _items;
  final Map<String, StreamController<Product>> _controllers = {};
  final Map<String, Set<String>> _likedBy = {}; // productId -> set(userId)

  int _indexOf(String id) => _items.indexWhere((p) => p.id == id);

  void _emit(Product p) {
    final i = _indexOf(p.id);
    if (i != -1) _items[i] = p;
    _controllers[p.id]?.add(p);
  }

  // ---------------- Repository API ----------------

  @override
  Future<List<Product>> fetchFeed(
      {int limit = 20, String? categoryFilter}) async {
    Iterable<Product> list = _items.toList()
      ..sort((a, b) => b.uploadedAt.compareTo(a.uploadedAt)); // newest first

    if (categoryFilter != null &&
        categoryFilter.trim().isNotEmpty &&
        categoryFilter != 'All') {
      final cf = categoryFilter.trim().toLowerCase();
      list = list.where((p) => p.categoryPath.toLowerCase().contains(cf));
    }
    return list.take(limit).toList();
  }

  @override
  Future<List<Product>> fetchSellerItems(String sellerId,
      {int limit = 20}) async {
    return _items.where((p) => p.sellerId == sellerId).take(limit).toList();
  }

  @override
  Future<List<Product>> fetchSimilar(String categoryPath,
      {int limit = 20}) async {
    final top = categoryPath.split('>').first.trim().toLowerCase();
    return _items
        .where((p) {
          final pTop = p.categoryPath.split('>').first.trim().toLowerCase();
          return pTop == top;
        })
        .take(limit)
        .toList();
  }

  @override
  Future<void> toggleLike({
    required String productId,
    required String userId,
  }) async {
    final i = _indexOf(productId);
    if (i == -1) return;

    final liked = _likedBy.putIfAbsent(productId, () => <String>{});
    final already = liked.contains(userId);

    if (already) {
      liked.remove(userId);
    } else {
      liked.add(userId);
    }

    final p = _items[i];
    final updated = p.copyWith(
      likes: already ? (p.likes - 1).clamp(0, 1 << 31) : p.likes + 1,
      likedByMe: !already,
    );
    _emit(updated);
  }

  @override
  Future<String> createProduct(Product product) async {
    final newId = 'p${_items.length + 1}';
    final withId = product.copyWith(id: newId, uploadedAt: DateTime.now());
    _items.insert(0, withId);

    _controllers[newId] = StreamController<Product>.broadcast();
    _emit(withId);

    return newId;
  }

  @override
  Stream<Product> watchProduct(String id, {String? currentUserId}) {
    final i = _indexOf(id);
    if (i == -1) return const Stream.empty();
    final ctrl = _controllers[id]!;
    // push current state to new listeners on next microtask
    scheduleMicrotask(() => ctrl.add(_items[i]));
    return ctrl.stream;
  }

  // ---------------- Demo data ----------------

  List<Product> _buildDemo() {
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
        seller:
            const Seller(username: 'theslyman', rating: 5.0, ratingCount: 1027),
        sellerId: 'u1',
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
        sellerId: 'u2',
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
        sellerId: 'u3',
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
        sellerId: 'u4',
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
        sellerId: 'u5',
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
        sellerId: 'u6',
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
        sellerId: 'u7',
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
        sellerId: 'u8',
        sellerUsername: 'lina',
        badges: const [],
        likes: 8,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 5, hours: 12)),
      ),
    ];
  }
}
