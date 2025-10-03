// lib/pages/product_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../state/app_state.dart';
import '../models/product.dart';
import '../models/seller.dart';
import 'make_offer_page.dart';
import 'checkout_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.product,
    this.sellersOtherItems,
    this.similarItems,
  });

  final Product product;
  final List<Product>? sellersOtherItems;
  final List<Product>? similarItems;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _pageCtrl = PageController();
  int _page = 0;

  /// Local “optimistic” override used when the backend stream doesn’t push
  /// updates (e.g., Fake repo). When Firebase streams, incoming snapshots
  /// will replace this UI automatically.
  Product? _optimistic;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  Future<void> _toggleLike(Product current) async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? 'dev-user'; // fallback for fake repo

    // Optimistic UI update
    final nextLiked = !current.likedByMe;
    final nextLikes =
        nextLiked ? (current.likes + 1) : (current.likes - 1).clamp(0, 1 << 31);

    setState(() {
      _optimistic = current.copyWith(likedByMe: nextLiked, likes: nextLikes);
    });

    try {
      await context.read<AppState>().toggleLike(current.id, userId: uid);
      // If you’re on Firebase, a snapshot will arrive and override _optimistic.
      // If you’re on the fake repo, we keep _optimistic so the UI stays updated.
    } catch (_) {
      // Rollback on failure
      setState(() => _optimistic = null);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update like.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUid = FirebaseAuth.instance.currentUser?.uid;

    // Fallback demo lists if none were injected
    final demoOthers =
        widget.sellersOtherItems ?? _demoProductsForSeller(widget.product);
    final demoSimilar =
        widget.similarItems ?? _demoSimilarProducts(widget.product);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<Product>(
        stream: context
            .read<AppState>()
            .watchProduct(widget.product.id, currentUserId: authUid),
        initialData: widget.product,
        builder: (context, snap) {
          // Use streamed data when available; otherwise fallback to initial;
          // then apply optimistic override if we have one.
          Product effective = (snap.data ?? widget.product);
          if (_optimistic != null && _optimistic!.id == effective.id) {
            effective = _optimistic!;
          }

          final t = Theme.of(context).textTheme;
          final cs = Theme.of(context).colorScheme;

          return CustomScrollView(
            slivers: [
              // ---------- Images + Like ----------
              SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageCtrl,
                        itemCount: effective.images.isEmpty
                            ? 1
                            : effective.images.length,
                        onPageChanged: (i) => setState(() => _page = i),
                        itemBuilder: (_, i) {
                          final url = effective.images.isEmpty
                              ? null
                              : effective.images[i];
                          return url == null
                              ? const ColoredBox(color: Color(0xFFEFEFEF))
                              : Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const ColoredBox(
                                          color: Color(0xFFEFEFEF)),
                                );
                        },
                      ),
                      Positioned(
                        right: 12,
                        bottom: 12,
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(999),
                          elevation: 4,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () => _toggleLike(effective),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    effective.likedByMe
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: effective.likedByMe
                                        ? Colors.red
                                        : Colors.black,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${effective.likes}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- Seller ----------
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: Row(
                    children: [
                      _SellerAvatar(
                        username: effective.seller.username,
                        url: effective.seller.avatarUrl,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              effective.seller.username,
                              style: t.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (i) => Icon(
                                    i < effective.seller.rating.round()
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 18,
                                    color: Colors.amber[700],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '(${effective.seller.ratingCount})',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Open chat with seller (mock)'),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: BorderSide(color: cs.outline),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        child: const Text('Ask seller'),
                      ),
                    ],
                  ),
                ),
              ),

              if (effective.badges.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: effective.badges
                          .map(
                            (b) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: cs.primary.withOpacity(.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.local_shipping_outlined,
                                      size: 18, color: cs.primary),
                                  const SizedBox(width: 6),
                                  Text(
                                    b,
                                    style: TextStyle(
                                      color: cs.primary,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: Divider(height: 1)),

              // ---------- Title / price / meta ----------
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        effective.title,
                        style: t.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Text(
                            effective.size,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const Text('·',
                              style: TextStyle(color: Colors.black45)),
                          Text(
                            effective.condition,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const Text('·',
                              style: TextStyle(color: Colors.black45)),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              effective.brand,
                              style: TextStyle(
                                color: cs.primary,
                                decoration: TextDecoration.underline,
                                decorationColor: cs.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '€${effective.price.toStringAsFixed(2)}',
                        style: t.titleLarge?.copyWith(
                          color: cs.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '€${(effective.price * 1.09).toStringAsFixed(2)} Includes Buyer Protection',
                            style: TextStyle(
                              color: Colors.teal[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.verified_user,
                              size: 18, color: Colors.teal[700]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: Divider(height: 1)),

              // ---------- Description ----------
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: t.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(effective.description),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Tap to translate'),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- Facts ----------
              SliverToBoxAdapter(
                child: _FactsTable(
                  rows: [
                    _FactRow(
                        'Category', effective.categoryPath.split(' > ').last),
                    _FactRow('Brand', effective.brand),
                    _FactRow('Size', effective.size),
                    _FactRow('Condition', effective.condition),
                    _FactRow('Colour', effective.colour),
                    _FactRow('Uploaded', _timeAgo(effective.uploadedAt)),
                  ],
                ),
              ),

              // ---------- Buyer protection ----------
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.verified, color: cs.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: const [
                                TextSpan(
                                  text: 'Buyer Protection fee\n',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text:
                                      'Our Buyer Protection is added for a fee to every purchase made with the "Buy now" button.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ---------- Postage ----------
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Postage',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          Text('From €2.79',
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The right of withdrawal of Article L. 221-18 ...',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- Tabs (member’s items / similar) ----------
              SliverToBoxAdapter(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const TabBar(
                        labelColor: Colors.black,
                        indicatorColor: Colors.teal,
                        tabs: [
                          Tab(text: "Member's items"),
                          Tab(text: 'Similar items'),
                        ],
                      ),
                      SizedBox(
                        height: 640,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _MemberItemsTab(products: demoOthers),
                            _SimilarItemsTab(products: demoSimilar),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),

      // ---------- Bottom actions ----------
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.06),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    final p = _optimistic ?? widget.product;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MakeOfferPage(
                          productTitle: p.title,
                          productPrice: p.price,
                          thumbUrl: p.images.isNotEmpty ? p.images.first : null,
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Make an offer'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    final p = _optimistic ?? widget.product;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CheckoutPage(product: p),
                      ),
                    );
                  },
                  child: const Text('Buy now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ========================= helper widgets & fns ========================= */

class _SellerAvatar extends StatelessWidget {
  const _SellerAvatar({required this.username, this.url});
  final String username;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final hasUrl = url != null && url!.trim().isNotEmpty;
    return CircleAvatar(
      radius: 22,
      backgroundImage: hasUrl ? NetworkImage(url!) : null,
      child: hasUrl
          ? null
          : Text(
              username.isNotEmpty ? username[0].toUpperCase() : '?',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
    );
  }
}

class _FactsTable extends StatelessWidget {
  const _FactsTable({required this.rows});
  final List<_FactRow> rows;

  @override
  Widget build(BuildContext context) {
    final divider = Divider(color: Theme.of(context).dividerColor, height: 1);
    return Column(
      children: [
        for (final r in rows) ...[
          ListTile(
            dense: true,
            title: Text(
              r.label,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(r.value),
          ),
          divider,
        ],
      ],
    );
  }
}

class _FactRow {
  final String label, value;
  const _FactRow(this.label, this.value);
}

class _MemberItemsTab extends StatelessWidget {
  const _MemberItemsTab({required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shop bundles',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    SizedBox(height: 2),
                    Text('Get up to 10% off',
                        style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: BorderSide(color: cs.outline),
                ),
                child: const Text('Create bundle'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .72,
              ),
              itemCount: products.length,
              itemBuilder: (_, i) => _GridProductCard(p: products[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SimilarItemsTab extends StatelessWidget {
  const _SimilarItemsTab({required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: .72,
        ),
        itemCount: products.length,
        itemBuilder: (_, i) => _GridProductCard(p: products[i]),
      ),
    );
  }
}

class _GridProductCard extends StatelessWidget {
  const _GridProductCard({required this.p});
  final Product p;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => ProductPage(product: p)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: p.images.isEmpty
                  ? const ColoredBox(color: Color(0xFFEFEFEF))
                  : Image.network(p.images.first, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.bodyMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '€${p.price.toStringAsFixed(2)}',
                    style: t.bodyMedium?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ========================= demo helpers ========================= */

String _timeAgo(DateTime dt) {
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours} h ago';
  final d = diff.inDays;
  return d == 1 ? '1 day ago' : '$d days ago';
}

List<Product> _demoProductsForSeller(Product base) => List.generate(6, (i) {
      return base.copyWith(
        id: 'seller-${i + 1}',
        title: '${base.brand} item ${i + 1}',
        price: (base.price * (0.8 + i * 0.07)),
        likes: 3 + i,
        uploadedAt: DateTime.now().subtract(Duration(hours: 2 * (i + 1))),
      );
    });

List<Product> _demoSimilarProducts(Product base) => List.generate(6, (i) {
      return Product(
        id: 'similar-${i + 1}',
        title: 'Similar ${base.title} ${i + 1}',
        brand: base.brand,
        price: (base.price * (0.75 + i * 0.06)),
        images: base.images,
        condition: 'Very good',
        size: base.size,
        colour: base.colour,
        categoryPath: base.categoryPath,
        description: 'Similar item in ${base.categoryPath}.',
        seller:
            const Seller(username: 'otherUser', rating: 5, ratingCount: 200),
        badges: const [],
        likes: 1 + i,
        likedByMe: false,
        uploadedAt: DateTime.now().subtract(Duration(hours: 3 * (i + 1))),
        sellerId: '',
        sellerUsername: '',
      );
    });
