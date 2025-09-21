class Seller {
  final String username;
  final double rating; // 0..5
  final int ratingCount;
  final String? avatarUrl; // <-- optional

  const Seller({
    required this.username,
    required this.rating,
    required this.ratingCount,
    this.avatarUrl, // <-- optional
  });
}
