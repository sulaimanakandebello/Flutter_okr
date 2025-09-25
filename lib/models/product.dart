/*
// lib/models/product.dart (excerpt)
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String title;
  final String brand;
  final double price;
  final List<String> images;
  final String condition;
  final String size;
  final String colour;
  final String categoryPath;
  final String description;
  final String sellerId;
  final String sellerUsername;
  final String? sellerAvatarUrl;
  final List<String> badges;
  final int likes;
  final bool likedByMe; // computed client-side
  final DateTime uploadedAt;

  Product(required String id, {
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.images,
    required this.condition,
    required this.size,
    required this.colour,
    required this.categoryPath,
    required this.description,
    required this.sellerId,
    required this.sellerUsername,
    this.sellerAvatarUrl,
    this.badges = const [],
    this.likes = 0,
    this.likedByMe = false,
    required this.uploadedAt,
    required seller,
  });

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc, {
    required String? currentUserId,
  }) {
    final d = doc.data()!;
    final likedBy = (d['likedBy'] as Map?)?.cast<String, dynamic>() ?? {};
    return Product(
      id: doc.id,
      title: d['title'] ?? '',
      brand: d['brand'] ?? '',
      price: (d['price'] ?? 0).toDouble(),
      images: (d['images'] as List? ?? []).cast<String>(),
      condition: d['condition'] ?? '',
      size: d['size'] ?? '',
      colour: d['colour'] ?? '',
      categoryPath: d['categoryPath'] ?? '',
      description: d['description'] ?? '',
      sellerId: d['sellerId'] ?? '',
      sellerUsername: d['sellerUsername'] ?? '',
      sellerAvatarUrl: d['sellerAvatarUrl'],
      badges: (d['badges'] as List? ?? []).cast<String>(),
      likes: (d['likesCount'] ?? 0) as int,
      likedByMe:
          currentUserId == null ? false : (likedBy[currentUserId] == true),
      uploadedAt: (d['uploadedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'brand': brand,
        'price': price,
        'images': images,
        'condition': condition,
        'size': size,
        'colour': colour,
        'categoryPath': categoryPath,
        'description': description,
        'sellerId': sellerId,
        'sellerUsername': sellerUsername,
        'sellerAvatarUrl': sellerAvatarUrl,
        'badges': badges,
        'likesCount': likes,
        'uploadedAt': Timestamp.fromDate(uploadedAt),
      };
}
*/

/*
// lib/models/product.dart
import 'seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String title;
  final String brand;
  final double price;
  final List<String> images;
  final String condition;
  final String size;
  final String colour;
  final String categoryPath; // e.g. "Women > Clothing > Jeans"
  final String description;

  // Seller info (nested model)
  final Seller seller; // <-- bring this back
  final String sellerId; // useful for lookups (e.g., "u-<username>")
  final String sellerUsername; // convenience copy

  // Meta
  final List<String> badges;
  final int likes;
  final bool likedByMe;
  final DateTime uploadedAt;

  const Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.images,
    required this.condition,
    required this.size,
    required this.colour,
    required this.categoryPath,
    required this.description,
    required this.seller, // <-- required
    required this.sellerId, // <-- required
    required this.sellerUsername, // <-- required
    this.badges = const [],
    this.likes = 0,
    this.likedByMe = false,
    required this.uploadedAt,
  });
}
*/

// lib/models/product.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'seller.dart';

class Product {
  final String id;
  final String title;
  final String brand;
  final double price;
  final List<String> images;
  final String condition;
  final String size;
  final String colour;
  final String categoryPath;
  final String description;

  /// Embedded summary for quick display (can be minimal).
  final Seller seller;

  /// Redundant seller fields to make querying simpler.
  final String sellerId;
  final String sellerUsername;

  final List<String> badges;

  /// Denormalized likes count
  final int likes;

  /// Derived at runtime from Firestore's `likedBy[userId]`
  final bool likedByMe;

  final DateTime uploadedAt;

  const Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.images,
    required this.condition,
    required this.size,
    required this.colour,
    required this.categoryPath,
    required this.description,
    required this.seller,
    required this.sellerId,
    required this.sellerUsername,
    this.badges = const [],
    this.likes = 0,
    this.likedByMe = false,
    required this.uploadedAt,
  });

  /// Build from Firestore snapshot.
  static Product fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc, {
    String? currentUserId,
  }) {
    final data = doc.data() ?? <String, dynamic>{};

    // Lists (images, badges)
    final images = <String>[
      for (final v in (data['images'] as List? ?? const []))
        if (v is String) v,
    ];
    final badges = <String>[
      for (final v in (data['badges'] as List? ?? const []))
        if (v is String) v,
    ];

    // Seller embedded map is optional; fall back to the redundant fields
    final sellerMap = (data['seller'] as Map?)?.cast<String, dynamic>() ?? {};
    final sellerUsername = (data['sellerUsername'] as String?) ??
        (sellerMap['username'] as String?) ??
        '';
    final sellerRating = (sellerMap['rating'] as num?)?.toDouble() ??
        (data['sellerRating'] as num?)?.toDouble() ??
        0.0;
    final sellerRatingCount = (sellerMap['ratingCount'] as num?)?.toInt() ??
        (data['sellerRatingCount'] as num?)?.toInt() ??
        0;
    final sellerAvatarUrl = (sellerMap['avatarUrl'] as String?) ??
        (data['sellerAvatarUrl'] as String?);

    // Likes map and count
    final likedBy = (data['likedBy'] as Map?)?.cast<String, dynamic>() ??
        const <String, dynamic>{};
    final likesCount = (data['likesCount'] as num?)?.toInt() ?? 0;
    final likedByMe =
        currentUserId == null ? false : (likedBy[currentUserId] == true);

    // uploadedAt can be Timestamp or ISO string; default to now if missing.
    DateTime uploadedAt;
    final rawUploadedAt = data['uploadedAt'];
    if (rawUploadedAt is Timestamp) {
      uploadedAt = rawUploadedAt.toDate();
    } else if (rawUploadedAt is String) {
      uploadedAt = DateTime.tryParse(rawUploadedAt) ?? DateTime.now();
    } else {
      uploadedAt = DateTime.now();
    }

    return Product(
      id: doc.id,
      title: (data['title'] as String?) ?? '',
      brand: (data['brand'] as String?) ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      images: images,
      condition: (data['condition'] as String?) ?? '',
      size: (data['size'] as String?) ?? '',
      colour: (data['colour'] as String?) ?? '',
      categoryPath: (data['categoryPath'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      seller: Seller(
        username: sellerUsername,
        rating: sellerRating,
        ratingCount: sellerRatingCount,
        avatarUrl: sellerAvatarUrl,
      ),
      sellerId: (data['sellerId'] as String?) ?? '',
      sellerUsername: sellerUsername,
      badges: badges,
      likes: likesCount,
      likedByMe: likedByMe,
      uploadedAt: uploadedAt,
    );
  }

  /// Convert to a Firestore map. Note: `id` is not stored in the doc.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'brand': brand,
      'price': price,
      'images': images,
      'condition': condition,
      'size': size,
      'colour': colour,
      'categoryPath': categoryPath,
      'description': description,
      'seller': {
        'username': seller.username,
        'rating': seller.rating,
        'ratingCount': seller.ratingCount,
        if (seller.avatarUrl != null) 'avatarUrl': seller.avatarUrl,
      },
      'sellerId': sellerId,
      'sellerUsername': sellerUsername,
      'badges': badges,
      // likes/likedBy should be updated via transactions; initialize as needed:
      'likesCount': likes,
      'uploadedAt': Timestamp.fromDate(uploadedAt),
    };
  }

  Product copyWith({
    String? id,
    String? title,
    String? brand,
    double? price,
    List<String>? images,
    String? condition,
    String? size,
    String? colour,
    String? categoryPath,
    String? description,
    Seller? seller,
    String? sellerId,
    String? sellerUsername,
    List<String>? badges,
    int? likes,
    bool? likedByMe,
    DateTime? uploadedAt,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      images: images ?? this.images,
      condition: condition ?? this.condition,
      size: size ?? this.size,
      colour: colour ?? this.colour,
      categoryPath: categoryPath ?? this.categoryPath,
      description: description ?? this.description,
      seller: seller ?? this.seller,
      sellerId: sellerId ?? this.sellerId,
      sellerUsername: sellerUsername ?? this.sellerUsername,
      badges: badges ?? this.badges,
      likes: likes ?? this.likes,
      likedByMe: likedByMe ?? this.likedByMe,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
