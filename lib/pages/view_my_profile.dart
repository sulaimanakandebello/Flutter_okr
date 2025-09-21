import "package:flutter/material.dart";
import 'sell_page.dart'; // adjust path if you put it elsewhere

/* -------------------- Simple data models -------------------- */
class ListingItem {
  final String title;
  final double price;
  final String imageUrl;
  const ListingItem({
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}

class Review {
  final String author;
  final int stars; // 1..5
  final String comment;
  final DateTime date;
  const Review({
    required this.author,
    required this.stars,
    required this.comment,
    required this.date,
  });
}

/* -------------------- Profile Detail Page -------------------- */
class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({
    super.key,
    required this.username,
    this.listings = const [],
    this.reviews = const [],
    this.bio,
    this.location,
    this.joined,
  });

  final String username;
  final List<ListingItem> listings;
  final List<Review> reviews;
  final String? bio;
  final String? location;
  final DateTime? joined;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(username),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Listings'),
              Tab(text: 'Reviews'),
              Tab(text: 'About'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ListingsTab(
              items: listings,
              onListNow: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SellPage()),
                );
              },
            ),
            _ReviewsTab(reviews: reviews),
            _AboutTab(
              username: username,
              bio: bio,
              location: location,
              joined: joined,
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------- Listings tab -------------------- */
class _ListingsTab extends StatelessWidget {
  const _ListingsTab({required this.items, required this.onListNow});

  final List<ListingItem> items;
  final VoidCallback onListNow;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return _EmptyListings(onListNow: onListNow);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: .68,
        ),
        itemBuilder: (_, i) => _ListingCard(item: items[i]),
      ),
    );
  }
}

class _EmptyListings extends StatelessWidget {
  const _EmptyListings({required this.onListNow});
  final VoidCallback onListNow;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.auto_awesome_motion_outlined,
              size: 72,
              color: Colors.teal,
            ),
            const SizedBox(height: 16),
            Text(
              'List items to start selling',
              style: t.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Declutter your life. Sell what you don’t wear anymore!',
              style: t.bodyMedium?.copyWith(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onListNow, child: const Text('List now')),
          ],
        ),
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  const _ListingCard({required this.item});
  final ListingItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          /* TODO: open listing detail */
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const ColoredBox(color: Color(0xFFEFEFEF)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                '€${item.price.toStringAsFixed(2)}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------- Reviews tab -------------------- */
class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab({required this.reviews});
  final List<Review> reviews;

  double get _avg => reviews.isEmpty
      ? 0
      : reviews.map((r) => r.stars).reduce((a, b) => a + b) / reviews.length;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        Center(
          child: Column(
            children: [
              Text(_avg.toStringAsFixed(1), style: t.displaySmall),
              const SizedBox(height: 4),
              _StarsRow(rating: _avg),
              const SizedBox(height: 4),
              Text(
                '(${reviews.length})',
                style: t.bodySmall?.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        ListTile(
          leading: const Icon(Icons.group_outlined),
          title: const Text('Member reviews'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_avg.toStringAsFixed(1)),
              const SizedBox(width: 4),
              const Icon(Icons.star, size: 18, color: Colors.amber),
            ],
          ),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.auto_awesome_outlined),
          title: const Text('Automatic reviews'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('5.0'),
              SizedBox(width: 4),
              Icon(Icons.star, size: 18, color: Colors.amber),
            ],
          ),
        ),

        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: const [
            _FilterChip(label: 'All', selected: true),
            _FilterChip(label: 'From members'),
            _FilterChip(label: 'Automatic'),
          ],
        ),
        const SizedBox(height: 12),

        ...reviews.map((r) => _ReviewTile(review: r)),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(child: Text(review.author[0].toUpperCase())),
          title: Text(
            review.author,
            style: t.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StarsRow(rating: review.stars.toDouble()),
              const SizedBox(height: 4),
              Text(review.comment),
            ],
          ),
          trailing: Text(
            _ago(review.date),
            style: t.bodySmall?.copyWith(color: Colors.black54),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  String _ago(DateTime date) {
    final d = DateTime.now().difference(date);
    if (d.inDays >= 30) return '${d.inDays ~/ 30} months ago';
    if (d.inDays >= 1) return '${d.inDays} days ago';
    if (d.inHours >= 1) return '${d.inHours} hours ago';
    return 'Just now';
  }
}

class _StarsRow extends StatelessWidget {
  const _StarsRow({required this.rating});
  final double rating;

  @override
  Widget build(BuildContext context) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < full)
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        if (i == full && half)
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        return const Icon(Icons.star_border, color: Colors.amber, size: 20);
      }),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.selected = false});
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {},
    );
  }
}

class _AboutTab extends StatelessWidget {
  const _AboutTab({
    required this.username,
    this.bio,
    this.location,
    this.joined,
    this.lastSeen,
    this.isGoogleVerified = true,
    this.isEmailVerified = true,
    this.followers = 0,
    this.following = 0,
  });

  final String username;
  final String? bio;
  final String? location;
  final DateTime? joined;
  final DateTime? lastSeen;
  final bool isGoogleVerified;
  final bool isEmailVerified;
  final int followers;
  final int following;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return ListView(
      children: [
        // Square, full-width banner with the initial
        AspectRatio(
          aspectRatio: 1, // width : height = 1:1
          child: LayoutBuilder(
            builder: (context, constraints) {
              final side = constraints.maxWidth;
              final fontSize = side * 0.45; // scale letter to square size
              return Container(
                color: cs.primary,
                alignment: Alignment.center,
                child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : '?',
                  style: t.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                  ),
                ),
              );
            },
          ),
        ),

        // Username
        Container(
          color: cs.surface,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            username,
            style: t.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const Divider(height: 1),

        // Verified info header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Verified info',
            style: t.bodyMedium?.copyWith(color: Colors.black54),
          ),
        ),
        _VerifiedRow(label: 'Google', verified: isGoogleVerified),
        const _SectionDivider(),
        _VerifiedRow(label: 'Email', verified: isEmailVerified),

        const _SectionSpacer(), // light grey block separator
        // Location
        _IconLine(icon: Icons.place_outlined, text: location ?? '—'),
        const _SectionDivider(),

        // Last seen
        _IconLine(
          icon: Icons.access_time,
          text: 'Last seen ${_relative(lastSeen)}',
        ),
        const _SectionDivider(),

        // Followers / Following (links)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.rss_feed_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _LinkText(
                      '$followers followers',
                      onTap: () {
                        /* TODO: open followers */
                      },
                    ),
                    const Text(', '),
                    _LinkText(
                      '$following following',
                      onTap: () {
                        /* TODO: open following */
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  static String _relative(DateTime? dt) {
    if (dt == null) return 'just now';
    final d = DateTime.now().difference(dt);
    if (d.inMinutes < 1) return 'just now';
    if (d.inHours < 1) return '${d.inMinutes} min ago';
    if (d.inDays < 1) return '${d.inHours} hours ago';
    return '${d.inDays} days ago';
  }
}

// --- small helpers used by the About tab ---

class _VerifiedRow extends StatelessWidget {
  const _VerifiedRow({required this.label, required this.verified});
  final String label;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final color = verified ? Colors.green : Colors.grey;
    final icon = verified
        ? Icons.check_circle_outline
        : Icons.radio_button_unchecked;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(label, style: t.titleMedium),
        ],
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: t.titleMedium)),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();
  @override
  Widget build(BuildContext context) => const Divider(height: 1);
}

class _SectionSpacer extends StatelessWidget {
  const _SectionSpacer();
  @override
  Widget build(BuildContext context) => Container(
    height: 8,
    color: Theme.of(context).dividerColor.withOpacity(0.15),
  );
}

class _LinkText extends StatelessWidget {
  const _LinkText(this.text, {required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

/*
/* -------------------- About tab -------------------- */
class _AboutTab extends StatelessWidget {
  const _AboutTab({
    required this.username,
    this.bio,
    this.location,
    this.joined,
  });

  final String username;
  final String? bio;
  final String? location;
  final DateTime? joined;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text('Username'),
          subtitle: Text(username),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          subtitle: Text(bio?.isNotEmpty == true ? bio! : 'No bio yet'),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.place_outlined),
          title: const Text('Location'),
          subtitle: Text(location ?? 'Not set'),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.calendar_today_outlined),
          title: const Text('Member since'),
          subtitle: Text(
            joined == null
                ? '—'
                : '${joined!.year}-${joined!.month.toString().padLeft(2, '0')}-${joined!.day.toString().padLeft(2, '0')}',
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
*/
