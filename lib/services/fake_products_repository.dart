// lib/services/fake_products_repository.dart
import '../models/product.dart';

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
        badges: const [],
        likes: 8,
        likedByMe: false,
        uploadedAt: now.subtract(const Duration(days: 5, hours: 12)),
      ),
    ];
  }

  /// Optionally: items by the same seller
  List<Product> fetchBySeller(String username) {
    return fetchFeed().where((p) => p.seller.username == username).toList();
  }

  /// Optionally: items similar to a product (very basic: same top-level category)
  List<Product> fetchSimilar(Product base) {
    final top = base.categoryPath.split('>').first.trim();
    return fetchFeed().where((p) {
      final pTop = p.categoryPath.split('>').first.trim();
      return p.id != base.id && pTop == top;
    }).toList();
  }
}
