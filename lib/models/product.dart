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
  final String
      categoryPath; // e.g. "Women > Clothing > Jackets > Denim jackets"
  final String description;

  /// Embedded seller summary for quick display
  final Seller seller;

  /// Redundant fields to simplify queries
  final String sellerId;
  final String sellerUsername;

  final List<String> badges;

  /// Denormalized likes count (Firestore field: likesCount)
  final int likes;

  /// Derived locally from Firestore map `likedBy[userId]`
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

  /// Build from Firestore snapshot. `currentUserId` is used to compute `likedByMe`.
  static Product fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc, {
    String? currentUserId,
  }) {
    final data = doc.data() ?? <String, dynamic>{};

    final images = <String>[
      for (final v in (data['images'] as List? ?? const []))
        if (v is String) v,
    ];
    final badges = <String>[
      for (final v in (data['badges'] as List? ?? const []))
        if (v is String) v,
    ];

    // Likes & likedByMe
    final likedBy =
        (data['likedBy'] as Map?)?.cast<String, dynamic>() ?? const {};
    final likedByMe =
        currentUserId == null ? false : (likedBy[currentUserId] == true);
    final likes = (data['likesCount'] as num?)?.toInt() ?? 0;

    // Seller (embedded) with fallbacks to flat fields if present
    final s = (data['seller'] as Map?)?.cast<String, dynamic>() ?? {};
    final sellerUsername =
        (data['sellerUsername'] as String?) ?? (s['username'] as String?) ?? '';

    // UploadedAt: handle Timestamp / String / missing
    final uploadedAtRaw = data['uploadedAt'];
    final uploadedAt = uploadedAtRaw is Timestamp
        ? uploadedAtRaw.toDate()
        : (uploadedAtRaw is String
            ? DateTime.tryParse(uploadedAtRaw) ?? DateTime.now()
            : DateTime.now());

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
        rating: (s['rating'] as num?)?.toDouble() ??
            (data['sellerRating'] as num?)?.toDouble() ??
            0.0,
        ratingCount: (s['ratingCount'] as num?)?.toInt() ??
            (data['sellerRatingCount'] as num?)?.toInt() ??
            0,
        avatarUrl:
            (s['avatarUrl'] as String?) ?? (data['sellerAvatarUrl'] as String?),
      ),
      sellerId: (data['sellerId'] as String?) ?? '',
      sellerUsername: sellerUsername,
      badges: badges,
      likes: likes,
      likedByMe: likedByMe,
      uploadedAt: uploadedAt,
    );
  }

  /// Convert to Firestore map. (We don't store `likedByMe` — it's derived.)
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
        'seller': {
          'username': seller.username,
          'rating': seller.rating,
          'ratingCount': seller.ratingCount,
          if (seller.avatarUrl != null) 'avatarUrl': seller.avatarUrl,
        },
        'sellerId': sellerId,
        'sellerUsername': sellerUsername,
        'badges': badges,
        'likesCount': likes,
        'uploadedAt': Timestamp.fromDate(uploadedAt),
      };

  /// Handy for optimistic UI updates (e.g., likes).
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
