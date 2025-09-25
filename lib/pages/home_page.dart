/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../models/product.dart';
import 'product_page.dart'; // <- ideally updated to accept models/Product

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchCtrl = TextEditingController();
  final _categories = const [
    'All',
    'Electronics',
    'Women',
    'Men',
    'Designer',
    'Kids',
    'Home'
  ];

  String _selected = 'All';
  bool _showShippingBanner = true;
  bool _didLoad = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_didLoad) {
        _didLoad = true;
        context.read<AppState>().loadInitial(); // or load feed
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didLoad) {
      _didLoad = true;
      context.read<AppState>().loadInitial();
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final query = _searchCtrl.text.trim().toLowerCase();

    final filtered = app.feed.where((p) {
      final inCat = _selected == 'All' ||
          p.categoryPath.toLowerCase().contains(_selected.toLowerCase());
      final matchesQuery = query.isEmpty ||
          p.title.toLowerCase().contains(query) ||
          p.brand.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query) ||
          p.condition.toLowerCase().contains(query) ||
          p.size.toLowerCase().contains(query);
      return inCat && matchesQuery;
    }).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Search for items',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final label = _categories[i];
                  return ChoiceChip(
                    label: Text(label),
                    selected: label == _selected,
                    onSelected: (_) => setState(() => _selected = label),
                  );
                },
              ),
            ),
          ),
          if (app.loading && app.feed.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          if (!app.loading && filtered.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: Text('No items found')),
              ),
            ),
          if (filtered.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.62,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _ItemCard(product: filtered[i]),
                  childCount: filtered.length,
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomSheet: _showShippingBanner
          ? SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text('Shipping fees will be added at checkout')),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          setState(() => _showShippingBanner = false),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.product});
  final Product product;

  double get _incl => (product.price * 1.091);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ProductPage(product: product)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      product.images.first,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const ColoredBox(color: Color(0xFFEFEFEF)),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.12),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border,
                              size: 18, color: cs.primary),
                          const SizedBox(width: 4),
                          Text('${product.likes}', style: t.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
              child: Text(product.brand,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${product.size} · ${product.condition}',
                style: t.bodySmall?.copyWith(color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('€${product.price.toStringAsFixed(2)}',
                      style: t.bodyMedium?.copyWith(color: Colors.black87)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '€${_incl.toStringAsFixed(2)} incl.',
                        style: t.bodyMedium?.copyWith(
                          color: Colors.teal[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.verified_user,
                          size: 16, color: Colors.teal[700]),
                    ],
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
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../models/product.dart';
import 'product_page.dart'; // ProductPage should accept models/Product

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchCtrl = TextEditingController();
  final _categories = const [
    'All',
    'Electronics',
    'Women',
    'Men',
    'Designer',
    'Kids',
    'Home',
  ];

  String _selected = 'All';
  bool _showShippingBanner = true;
  bool _didKickOff = false;

  @override
  void initState() {
    super.initState();
    // Kick off initial load AFTER the first frame — safe to notify then.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _didKickOff) return;
      _didKickOff = true;
      context.read<AppState>().loadInitial();
    });
  }

  // ❌ Remove didChangeDependencies that calls loadInitial()
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final query = _searchCtrl.text.trim().toLowerCase();

    final filtered = app.feed.where((p) {
      final inCat = _selected == 'All' ||
          p.categoryPath.toLowerCase().contains(_selected.toLowerCase());
      final matchesQuery = query.isEmpty ||
          p.title.toLowerCase().contains(query) ||
          p.brand.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query) ||
          p.condition.toLowerCase().contains(query) ||
          p.size.toLowerCase().contains(query);
      return inCat && matchesQuery;
    }).toList();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => context.read<AppState>().refreshFeed(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'Search for items',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),

            // Filter chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 42,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final label = _categories[i];
                    return ChoiceChip(
                      label: Text(label),
                      selected: label == _selected,
                      onSelected: (_) => setState(() => _selected = label),
                    );
                  },
                ),
              ),
            ),

            // Loading
            if (app.loading && app.feed.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),

            // Empty
            if (!app.loading && filtered.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: Text('No items found')),
                ),
              ),

            // Grid of items
            if (filtered.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.62,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _ItemCard(product: filtered[i]),
                    childCount: filtered.length,
                  ),
                ),
              ),

            // breathing room so last row isn't hidden by banners
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),

      // Shipping banner
      bottomSheet: _showShippingBanner
          ? SafeArea(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Shipping fees will be added at checkout'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          setState(() => _showShippingBanner = false),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.product});
  final Product product;

  double get _incl => (product.price * 1.091);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ProductPage(product: product)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image flexes to prevent text overflow
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      product.images.isNotEmpty
                          ? product.images.first
                          : 'https://via.placeholder.com/400x400?text=No+Image',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const ColoredBox(color: Color(0xFFEFEFEF)),
                    ),
                  ),
                  // Likes bubble
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.12),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: cs.primary,
                          ),
                          const SizedBox(width: 4),
                          Text('${product.likes}', style: t.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Brand
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
              child: Text(
                product.brand,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Size · Condition
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${product.size} · ${product.condition}',
                style: t.bodySmall?.copyWith(color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Prices
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '€${product.price.toStringAsFixed(2)}',
                    style: t.bodyMedium?.copyWith(color: Colors.black87),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '€${_incl.toStringAsFixed(2)} incl.',
                        style: t.bodyMedium?.copyWith(
                          color: Colors.teal[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.verified_user,
                        size: 16,
                        color: Colors.teal[700],
                      ),
                    ],
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
