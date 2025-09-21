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
