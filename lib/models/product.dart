/*
// lib/models/product.dart
class Seller {
  final String username;
  final double rating; // 0..5
  final int ratingCount;
  final String? avatarUrl; // optional

  const Seller({
    required this.username,
    required this.rating,
    required this.ratingCount,
    this.avatarUrl,
  });
}

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
  final Seller seller;
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
    required this.seller,
    this.badges = const [],
    this.likes = 0,
    this.likedByMe = false,
    required this.uploadedAt,
  });

  Product copyWith({bool? likedByMe, int? likes}) {
    return Product(
      id: id,
      title: title,
      brand: brand,
      price: price,
      images: images,
      condition: condition,
      size: size,
      colour: colour,
      categoryPath: categoryPath,
      description: description,
      seller: seller,
      badges: badges,
      likes: likes ?? this.likes,
      likedByMe: likedByMe ?? this.likedByMe,
      uploadedAt: uploadedAt,
    );
  }
}
*/

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

  Product({
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
