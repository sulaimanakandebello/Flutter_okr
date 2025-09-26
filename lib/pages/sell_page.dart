/*
import 'package:flutter/material.dart';

import 'category_page.dart';
import 'price_page.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class CategoryPick {
  /// Each level’s label, e.g. ['Women','Clothing','Outerwear','Jackets','Denim jackets']
  final List<String> labels;

  const CategoryPick(this.labels);

  /// Full breadcrumb string: Women > Clothing > Outerwear > Jackets > Denim jackets
  String get fullPath => labels.join(' > ');

  /// The final leaf only: Denim jackets
  String get leaf => labels.isNotEmpty ? labels.last : '';
}

class _SellPageState extends State<SellPage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  // Mock photos so the page works without extra packages.
  final List<Color> _mockPhotos = [];

  String? _category;
  double? _price;
  CategoryPick? _categoryPick; // full info (labels, fullPath, leaf)
  String? _categoryPath; // cached "Women > Clothing > …"
  String? _categoryLeaf; // cached "Denim jackets"

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _titleCtrl.text.trim().isNotEmpty &&
      _categoryPath != null &&
      _price != null;

  /*
  Future<void> _openCategory() async {
    final result = await Navigator.push<CategoryPick>(
      context,
      MaterialPageRoute(builder: (_) => const CategoryPage()),
    );
    if (result != null) {
      setState(() {
        _categoryPick = result;
        _categoryPath = result.fullPath; // store full breadcrumb
        _categoryLeaf = result.leaf; // short label for UI
      });
    }
  }*/

  Future<void> _openCategory() async {
    final result = await Navigator.push<dynamic>(
      context,
      MaterialPageRoute(builder: (_) => const CategoryPage()),
    );

    if (!mounted || result == null) return;

    if (result is CategoryPick) {
      setState(() {
        _categoryPath = result.fullPath;
        _categoryLeaf = result.leaf;
      });
    } else if (result is String) {
      // Backward compatibility if some page still returns a String
      setState(() {
        _categoryPath = result;
        _categoryLeaf = result.split(' > ').last;
      });
    }
  }

  Future<void> _openPrice() async {
    final result = await Navigator.push<double>(
      context,
      MaterialPageRoute(builder: (_) => PricePage(initial: _price)),
    );
    if (result != null) setState(() => _price = result);
  }

  void _addMockPhoto() {
    final colors = [
      Colors.blueGrey,
      Colors.teal,
      Colors.purple,
      Colors.indigo,
      Colors.orange,
    ];
    setState(() => _mockPhotos.add(colors[_mockPhotos.length % colors.length]));
  }

  void _removePhotoAt(int index) {
    setState(() => _mockPhotos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    const bottomBarHeight = 72.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Sell an item'),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, bottomBarHeight + 16),
        children: [
          // ------------------ Photos ------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: _mockPhotos.isEmpty
                ? OutlinedButton.icon(
                    onPressed: _addMockPhoto,
                    icon: const Icon(Icons.add),
                    label: const Text('Upload photos'),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (int i = 0; i < _mockPhotos.length; i++)
                            _PhotoTile(
                              color: _mockPhotos[i],
                              onRemove: () => _removePhotoAt(i),
                            ),
                          InkWell(
                            onTap: _addMockPhoto,
                            child: Container(
                              width: 92,
                              height: 92,
                              decoration: BoxDecoration(
                                border: Border.all(color: cs.outline),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _addMockPhoto,
                        child: const Text('Add more photos'),
                      ),
                    ],
                  ),
          ),

          // Tip banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.crop_free_outlined),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text("Catch your buyers’ eye — use quality photos."),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Learn how')),
                ],
              ),
            ),
          ),
          const _SectionRule(),

          // ------------------ Title ------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: t.bodyMedium?.copyWith(color: Colors.black54),
                ),
                TextField(
                  controller: _titleCtrl,
                  decoration: const InputDecoration(
                    hintText: 'e.g. White COS Jumper',
                    border: InputBorder.none,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          const _SectionRule(),

          // ------------------ Description ------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Describe your item',
                  style: t.bodyMedium?.copyWith(color: Colors.black54),
                ),
                TextField(
                  controller: _descCtrl,
                  decoration: const InputDecoration(
                    hintText: 'e.g. only worn a few times, true to size',
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 6,
                ),
              ],
            ),
          ),
          const _BlockSpacer(),

          // ------------------ Category ------------------
          ListTile(
            title: const Text('Category'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_categoryLeaf != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      _categoryLeaf!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: _openCategory,
          ),
          const Divider(height: 1),

          // ------------------ Price ------------------
          ListTile(
            title: const Text('Price'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_price != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      '€${_price!.toStringAsFixed(2)}',
                      style: t.bodyMedium,
                    ),
                  ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: _openPrice,
          ),
          const _BlockSpacer(),

          // Feedback prompt
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Expanded(
                  child: Text('What do you think of our upload process?'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Give feedback'),
                ),
              ],
            ),
          ),
        ],
      ),

      // ------------------ Bottom Upload button (no bottom nav here) ------------------
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: FilledButton(
              onPressed: _isValid
                  ? () {
                      // TODO: send to backend
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item uploaded (mock).')),
                      );
                      Navigator.pop(
                        context,
                      ); // back to AppShell (bottom nav visible)
                    }
                  : null,
              child: const Text('Upload'),
            ),
          ),
        ),
      ),
    );
  }
}

/// Photo tile with a removable "X" at top-right
class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.color, required this.onRemove});
  final Color color;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

/// Light section separators to match the screenshot
class _SectionRule extends StatelessWidget {
  const _SectionRule();
  @override
  Widget build(BuildContext context) => Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 16),
    color: Theme.of(context).dividerColor,
  );
}

class _BlockSpacer extends StatelessWidget {
  const _BlockSpacer();
  @override
  Widget build(BuildContext context) => Container(
    height: 8,
    color: Theme.of(context).dividerColor.withOpacity(.15),
  );
}

/* ---------------------------------------------------------------
   REAL PHOTO PICKING (optional):
   - Add to pubspec.yaml: image_picker: ^1.0.0 (or latest)
   - import 'package:image_picker/image_picker.dart';
   - Replace _mockPhotos logic with picking XFile(s) and show Image.memory/File.
   --------------------------------------------------------------- */
*/

// lib/pages/sell_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../state/app_state.dart';
import '../services/storage_service.dart';
import '../models/product.dart';
import '../models/seller.dart';

import 'category_page.dart';
import 'price_page.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

/// Keep the same helper the rest of your app expects
class CategoryPick {
  /// Each level’s label, e.g. ['Women','Clothing','Outerwear','Jackets','Denim jackets']
  final List<String> labels;
  const CategoryPick(this.labels);

  /// Full breadcrumb string: Women > Clothing > Outerwear > Jackets > Denim jackets
  String get fullPath => labels.join(' > ');

  /// The final leaf only: Denim jackets
  String get leaf => labels.isNotEmpty ? labels.last : '';
}

class _SellPageState extends State<SellPage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  // ⬇️ Keep the same variable name but store picked images instead of Colors
  final List<XFile> _mockPhotos = [];

  String? _category;
  double? _price;
  CategoryPick? _categoryPick; // full info (labels, fullPath, leaf)
  String? _categoryPath; // cached "Women > Clothing > …"
  String? _categoryLeaf; // cached "Denim jackets"

  bool _busy = false;
  final _picker = ImagePicker();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _titleCtrl.text.trim().isNotEmpty &&
      _categoryPath != null &&
      _price != null &&
      _mockPhotos.isNotEmpty;

  // ------------------------ Category ------------------------

  Future<void> _openCategory() async {
    final result = await Navigator.push<dynamic>(
      context,
      MaterialPageRoute(builder: (_) => const CategoryPage()),
    );
    if (!mounted || result == null) return;

    if (result is CategoryPick) {
      setState(() {
        _categoryPick = result;
        _categoryPath = result.fullPath;
        _categoryLeaf = result.leaf;
      });
    } else if (result is String) {
      // Backward-compat if some page still returns a String
      setState(() {
        _categoryPick = null;
        _categoryPath = result;
        _categoryLeaf = result.split(' > ').last;
      });
    }
  }

  Future<void> _openPrice() async {
    final result = await Navigator.push<double>(
      context,
      MaterialPageRoute(builder: (_) => PricePage(initial: _price)),
    );
    if (result != null) setState(() => _price = result);
  }

  // ------------------------ Photos ------------------------

  Future<void> _addMockPhoto() async {
    // Keep the same method name but pick real images now
    final files = await _picker.pickMultiImage(imageQuality: 85);
    if (files.isNotEmpty) {
      setState(() => _mockPhotos.addAll(files));
    }
  }

  void _removePhotoAt(int index) {
    setState(() => _mockPhotos.removeAt(index));
  }

  // ------------------------ Submit ------------------------

  Future<void> _submit() async {
    if (!_isValid) {
      _toast('Please add photos, a title, category, and a valid price.');
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _toast('Please sign in first.');
      return;
    }

    setState(() => _busy = true);
    try {
      // 1) Upload photos to Storage
      final urls = await StorageService().uploadProductImages(
        uid: user.uid,
        files: _mockPhotos,
      );

      // 2) Build Product model (using your existing Product/Seller)
      final sellerDisplayName = user.displayName?.trim().isNotEmpty == true
          ? user.displayName!
          : (user.email ?? 'user');

      final product = Product(
        id: 'temp', // repo will assign an id
        title: _titleCtrl.text.trim(),
        brand: '', // optional—extend UI later if you want
        price: _price!, // already validated
        images: urls,
        condition: 'Used - good', // extend UI later to pick condition
        size: '', // optional
        colour: '', // optional
        categoryPath: _categoryPath!,
        description: _descCtrl.text.trim(),
        seller: Seller(
          username: sellerDisplayName,
          rating: 5.0,
          ratingCount: 0,
          avatarUrl: null,
        ),
        sellerId: user.uid,
        sellerUsername: sellerDisplayName,
        badges: const [],
        likes: 0,
        likedByMe: false,
        uploadedAt: DateTime.now(),
      );

      // 3) Persist via the repo on AppState
      final app = context.read<AppState>();
      final newId = await app.repo.createListing(product);

      _toast('Listing created!');
      if (!mounted) return;
      Navigator.pop(context); // back to AppShell
      // Optionally: navigate to the new product detail page with newId
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    const bottomBarHeight = 72.0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Sell an item'),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, bottomBarHeight + 16),
        children: [
          // ------------------ Photos ------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: _mockPhotos.isEmpty
                ? OutlinedButton.icon(
                    onPressed: _busy ? null : _addMockPhoto,
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: const Text('Upload photos'),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (int i = 0; i < _mockPhotos.length; i++)
                            _PhotoTile(
                              file: _mockPhotos[i],
                              onRemove: _busy ? null : () => _removePhotoAt(i),
                            ),
                          InkWell(
                            onTap: _busy ? null : _addMockPhoto,
                            child: Container(
                              width: 92,
                              height: 92,
                              decoration: BoxDecoration(
                                border: Border.all(color: cs.outline),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _busy ? null : _addMockPhoto,
                        child: const Text('Add more photos'),
                      ),
                    ],
                  ),
          ),

          // Tip banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(Icons.crop_free_outlined),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text("Catch your buyers’ eye — use quality photos."),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Learn how')),
                ],
              ),
            ),
          ),
          const _SectionRule(),

          // ------------------ Title ------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: t.bodyMedium?.copyWith(color: Colors.black54),
                ),
                TextField(
                  controller: _titleCtrl,
                  decoration: const InputDecoration(
                    hintText: 'e.g. White COS Jumper',
                    border: InputBorder.none,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          const _SectionRule(),

          // ------------------ Description ------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Describe your item',
                  style: t.bodyMedium?.copyWith(color: Colors.black54),
                ),
                TextField(
                  controller: _descCtrl,
                  decoration: const InputDecoration(
                    hintText: 'e.g. only worn a few times, true to size',
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 6,
                ),
              ],
            ),
          ),
          const _BlockSpacer(),

          // ------------------ Category ------------------
          ListTile(
            title: const Text('Category'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_categoryLeaf != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      _categoryLeaf!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: _busy ? null : _openCategory,
          ),
          const Divider(height: 1),

          // ------------------ Price ------------------
          ListTile(
            title: const Text('Price'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_price != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      '€${_price!.toStringAsFixed(2)}',
                      style: t.bodyMedium,
                    ),
                  ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: _busy ? null : _openPrice,
          ),
          const _BlockSpacer(),

          // Feedback prompt
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Expanded(
                  child: Text('What do you think of our upload process?'),
                ),
                OutlinedButton(
                  onPressed: _busy ? null : () {},
                  child: const Text('Give feedback'),
                ),
              ],
            ),
          ),
        ],
      ),

      // ------------------ Bottom Upload button (no bottom nav here) ------------------
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: FilledButton(
              onPressed: _isValid && !_busy ? _submit : null,
              child: _busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Upload'),
            ),
          ),
        ),
      ),
    );
  }
}

/// Photo tile with removable "X" — keep the class name but show the picked image
class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.file, this.onRemove});
  final XFile file;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(file.path),
            width: 92,
            height: 92,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

/// Light section separators to match the screenshot
class _SectionRule extends StatelessWidget {
  const _SectionRule();
  @override
  Widget build(BuildContext context) => Container(
        height: 1,
        margin: const EdgeInsets.symmetric(vertical: 16),
        color: Theme.of(context).dividerColor,
      );
}

class _BlockSpacer extends StatelessWidget {
  const _BlockSpacer();
  @override
  Widget build(BuildContext context) => Container(
        height: 8,
        color: Theme.of(context).dividerColor.withOpacity(.15),
      );
}

/* ---------------------------------------------------------------
   Requirements:
   - pubspec.yaml: image_picker ^1.x
   - iOS Info.plist: NSPhotoLibraryUsageDescription, NSCameraUsageDescription
   - Android: INTERNET permission (usually present)
   - Ensure Firebase is initialized and user is signed in
   --------------------------------------------------------------- */
