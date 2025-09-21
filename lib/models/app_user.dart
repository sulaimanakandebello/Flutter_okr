class AppUser {
  final String username;
  final String? location;
  final DateTime? lastSeen;
  final int followers;
  final int following;

  const AppUser({
    required this.username,
    this.location,
    this.lastSeen,
    this.followers = 0,
    this.following = 0,
  });
}
