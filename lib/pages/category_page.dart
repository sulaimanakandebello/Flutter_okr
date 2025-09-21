import "package:flutter/material.dart";
import "package:flutter_okr/pages/sell_page.dart";

/// ---------------------------------------------------------------------------
/// Data model for a category tree
/// ---------------------------------------------------------------------------
class CategoryNode {
  final String label;
  final IconData? icon;
  final List<CategoryNode> children;
  const CategoryNode(this.label, {this.icon, this.children = const []});
  bool get isLeaf => children.isEmpty;
}

/// Build the category tree shown in your screenshots
CategoryNode _buildRootTree() {
  const women = CategoryNode(
    'Women',
    icon: Icons.woman_outlined,
    children: [
      CategoryNode(
        'Clothing',
        icon: Icons.checkroom_outlined,
        children: [
          CategoryNode(
            'Outerwear',
            children: [
              CategoryNode(
                'Jackets',
                children: [
                  CategoryNode('Denim jackets'),
                  CategoryNode('Bomber jackets'),
                  CategoryNode('Biker jackets'),
                  CategoryNode('Field & utility jacket'),
                  CategoryNode('Fleece jacket'),
                  CategoryNode('Puffer jacket'),
                  CategoryNode('Windbreakers'),
                  CategoryNode('Quilted jackets'),
                ],
              ),
              CategoryNode(
                'Coats',
                children: [
                  CategoryNode('Duffle coats'),
                  CategoryNode('Faux fur coats'),
                  CategoryNode('Overcoats & long coats'),
                  CategoryNode('Parkas'),
                  CategoryNode('Raincoats'),
                  CategoryNode('Trench coats'),
                  CategoryNode('Sports coats'),
                ],
              ),
              CategoryNode('Body warmers'),
              CategoryNode('Capes & ponchos'),
            ],
          ),
          CategoryNode(
            'Jumpers & sweaters',
            children: [
              CategoryNode('Hoodies & sweatshirts'),
              CategoryNode('Jumpers'),
              CategoryNode('Cardigans'),
              CategoryNode('Waistcoats'),
              CategoryNode('Sweaters'),
            ],
          ),
          CategoryNode(
            'Suits & blazers',
            children: [
              CategoryNode('Blazers'),
              CategoryNode('Trouser suits'),
              CategoryNode('Skirt suit'),
              CategoryNode('Suits separates'),
              CategoryNode('Other suits & blazers'),
            ],
          ),
          CategoryNode(
            'Dresses',
            children: [
              CategoryNode('Mini & midi dresses'),
              CategoryNode('Long dresses'),
              CategoryNode(
                'Special-occasion dresses',
                children: [
                  CategoryNode('Party & cocktail dresses'),
                  CategoryNode('Wedding dresses'),
                  CategoryNode('Evening dresses'),
                  CategoryNode('Backless dresses'),
                ],
              ),
              CategoryNode('Summer dresses'),
              CategoryNode('Winter dresses'),
              CategoryNode('Work dresses'),
              CategoryNode('Casual dresses'),
              CategoryNode('Strapless dresses'),
              CategoryNode('Black dresses'),
              CategoryNode('Denim dresses'),
              CategoryNode('Other dresses'),
            ],
          ),
          CategoryNode(
            'Skirts',
            children: [
              CategoryNode('Mini skirts'),
              CategoryNode('Knee-length skirts'),
              CategoryNode('Midi skirts'),
              CategoryNode('Maxi skirts'),
              CategoryNode('Skorts'),
              CategoryNode('Other skirts'),
            ],
          ),
          CategoryNode(
            'Tops & t-shirts',
            children: [
              CategoryNode('Shirts'),
              CategoryNode('Blouses'),
              CategoryNode('T-shirts'),
              CategoryNode('Vest tops & tank tops'),
              CategoryNode('Tunics'),
              CategoryNode('Crop tops'),
              CategoryNode('Short-sleeves tops'),
              CategoryNode('Long-sleeves tops'),
              CategoryNode('Bodysuits'),
              CategoryNode('Off-shoulder tops'),
              CategoryNode('Turtlenecks'),
              CategoryNode('Halternecks'),
              CategoryNode('Other tops & t-shirts'),
            ],
          ),
          CategoryNode(
            'Jeans',
            children: [
              CategoryNode('Cropped jeans'),
              CategoryNode('Flared jeans'),
              CategoryNode('High waisted jeans'),
              CategoryNode('Ripped jeans'),
              CategoryNode('Boyfriend jeans'),
              CategoryNode('Skinny jeans'),
              CategoryNode('Boyfriend jeans'),
              CategoryNode('Straight jeans'),
              CategoryNode('Others jeans'),
            ],
          ),
          CategoryNode(
            'Trousers & leggings',
            children: [
              CategoryNode('Cropped trousers & chinos'),
              CategoryNode('Wide-leg trousers'),
              CategoryNode('Skinny trousers'),
              CategoryNode('Tailored trousers'),
              CategoryNode('Straight trousers'),
              CategoryNode('Leather trousers'),
              CategoryNode('Leggings'),
              CategoryNode('Harem pants'),
              CategoryNode('Other trousers'),
            ],
          ),
          CategoryNode(
            'Shorts & cropped trousers',
            children: [
              CategoryNode('Low-waisted shorts'),
              CategoryNode('High-waisted shorts'),
              CategoryNode('Knee-length shorts'),
              CategoryNode('Denim shorts'),
              CategoryNode('Lace shorts'),
              CategoryNode('Leather shorts'),
              CategoryNode('Cargo shorts'),
              CategoryNode('Cropped trousers'),
              CategoryNode('Other shorts & cropped trousers'),
            ],
          ),
          CategoryNode(
            'Jumpsuits & playsuits',
            children: [
              CategoryNode('Jumpsuits'),
              CategoryNode('Playsuits'),
              CategoryNode('Other jumpsuits & playsuits'),
            ],
          ),
          CategoryNode(
            'Swimwear',
            children: [
              CategoryNode('One-pieces'),
              CategoryNode('Bikinis & tankinis'),
              CategoryNode('Cover-ups'),
              CategoryNode('Other swimwear & beachwear'),
            ],
          ),
          CategoryNode(
            'Lingerie & nightwear',
            children: [
              CategoryNode('Bras'),
              CategoryNode('Panties'),
              CategoryNode('Sets'),
              CategoryNode('Shapewear'),
              CategoryNode('Nightwear'),
              CategoryNode('Dressing gowns'),
              CategoryNode('Tights'),
              CategoryNode('Socks'),
              CategoryNode('Lingerie accessories'),
              CategoryNode('Other Lingerie & nightwear'),
            ],
          ),
          CategoryNode(
            'Maternity clothes',
            children: [
              CategoryNode('Maternity tops'),
              CategoryNode('Maternity dresses'),
              CategoryNode('Maternity skirts'),
              CategoryNode('Maternity trousers'),
              CategoryNode('Maternity shorts'),
              CategoryNode('Maternity jumpsuits & playsuits'),
              CategoryNode('Maternity jumpers & sweaters'),
              CategoryNode('Maternity coats  jackets'),
              CategoryNode('Maternity swimwear & beachwear'),
              CategoryNode(
                'Maternity underwear',
                children: [
                  CategoryNode('Maternity panties'),
                  CategoryNode('Maternity sleepwear'),
                  CategoryNode('Pregnancy & breastfeeding bras'),
                ],
              ),
              CategoryNode('Maternity activewear'),
            ],
          ),
          CategoryNode(
            'Activewear',
            children: [
              CategoryNode('Outerwear'),
              CategoryNode('Tracksuits'),
              CategoryNode('Trousers'),
              CategoryNode('Shorts'),
              CategoryNode('Dresses'),
              CategoryNode('Skirts'),
              CategoryNode('Tops & t-shirts'),
              CategoryNode('Jerseys'),
              CategoryNode('Hoodies & sweatshirts'),
              CategoryNode(
                'Sports accessories',
                children: [
                  CategoryNode('Glasses'),
                  CategoryNode('Gloves'),
                  CategoryNode('Sports caps'),
                  CategoryNode('Wristbands'),
                  CategoryNode('Other sports accessories'),
                ],
              ),
              CategoryNode('Sports bras'),
              CategoryNode('Other activewears'),
            ],
          ),
          CategoryNode('Costumes & special outfits'),
          CategoryNode('Other clothing'),
        ],
        //clothingChildren,
      ),

      CategoryNode(
        'Shoes',
        icon: Icons.directions_walk_outlined,
        children: [
          CategoryNode('Boat shoes, loafers & moccasins'),
          CategoryNode(
            'Boots',
            children: [
              CategoryNode('Ankle boots'),
              CategoryNode('Mid-calf boots'),
              CategoryNode('Knee-high boots'),
              CategoryNode('Over-the-knee boots'),
              CategoryNode('Wellington boots'),
              CategoryNode('Work boots'),
            ],
          ),
          CategoryNode('Flip-flops & slides'),
          CategoryNode('Heels'),
          CategoryNode('Lace-up shoes'),
          CategoryNode('Sandals'),
          CategoryNode('Slippers'),
          CategoryNode(
            'Sports shoes',
            children: [
              CategoryNode('Running shoes'),
              CategoryNode('Basketball shoes'),
              CategoryNode('Football boots'),
              CategoryNode('Indoor football shoes'),
              CategoryNode('Gym & indoor training shoes'),
              CategoryNode('Motorcycle boots'),
              CategoryNode('Tennis shoes'),
            ],
          ),
          CategoryNode('Sneakers & trainers'),
        ],
      ),

      CategoryNode(
        'Bags',
        icon: Icons.shopping_bag_outlined,
        children: [
          CategoryNode('Backpacks'),
          CategoryNode('Beach bags'),
          CategoryNode('Briefcases'),
          CategoryNode('Bucket bags'),
          CategoryNode('Bum bags'),
          CategoryNode('Clutches'),
          CategoryNode('Garment bags'),
          CategoryNode('Gym bags'),
          CategoryNode('Handbags'),
          CategoryNode('Duffelbags'),
          CategoryNode('Luggage & Suitcases'),
          CategoryNode('Makeup bags'),
          CategoryNode('Satchel & messenger bags'),
          CategoryNode('Shoulder bags'),
          CategoryNode('Tote bags'),
          CategoryNode('Wallets & purses'),
        ],
      ),
      CategoryNode(
        'Accessories',
        icon: Icons.watch_outlined,
        children: [
          CategoryNode('Scarves & handkerchiefs'),
          CategoryNode('Belts'),
          CategoryNode('Gloves'),
          CategoryNode('Hair accessories'),
          CategoryNode(
            'Hats & caps',
            children: [
              CategoryNode('Balaclavas'),
              CategoryNode('Beanies'),
              CategoryNode('Caps'),
              CategoryNode('Earmuffs'),
              CategoryNode('Hats'),
              CategoryNode('Headbands'),
            ],
          ),
          CategoryNode(
            'Jewellery',
            children: [
              CategoryNode('Anklets'),
              CategoryNode('Body jewellery'),
              CategoryNode('Bracelets'),
              CategoryNode('Brooches'),
              CategoryNode('Charms & pendants'),
              CategoryNode('Earrings'),
              CategoryNode('Jewellery sets'),
              CategoryNode('Necklaces'),
              CategoryNode('Rings'),
              CategoryNode('Other jewellery'),
            ],
          ),
          CategoryNode('Key rings'),
          CategoryNode('Shawls'),
          CategoryNode('Sunglasses'),
          CategoryNode('Umbrella'),
          CategoryNode('Watches'),
          CategoryNode('Other accessories'),
        ],
      ),
      CategoryNode(
        'Beauty',
        icon: Icons.brush_outlined,
        children: [
          CategoryNode('Make-up'),
          CategoryNode('Perfume'),
          CategoryNode('Facial care'),
          CategoryNode(
            'Beauty tools',
            children: [
              CategoryNode('Hair styling tools'),
              CategoryNode('Facial care tools'),
              CategoryNode('Body care tools'),
              CategoryNode('Nail care tools'),
              CategoryNode('Make-up tools'),
            ],
          ),
          CategoryNode('Hand care'),
          CategoryNode('Nail care'),
          CategoryNode('Body care'),
          CategoryNode('Hair care'),
          CategoryNode('Other beauty items'),
        ],
      ),
    ],
  );

  const men = CategoryNode(
    'Men',
    icon: Icons.man_outlined,
    children: [
      CategoryNode(
        'Clothing',
        icon: Icons.checkroom_outlined,
        children: [
          CategoryNode(
            'Outerwear',
            children: [
              CategoryNode(
                'Jackets',
                children: [
                  CategoryNode('Denim jackets'),
                  CategoryNode('Bomber jackets'),
                  CategoryNode('Biker jackets'),
                  CategoryNode('Field & utility jacket'),
                  CategoryNode('Fleece jacket'),
                  CategoryNode('Puffer jacket'),
                  CategoryNode('Windbreakers'),
                  CategoryNode('Quilted jackets'),
                ],
              ),
              CategoryNode(
                'Coats',
                children: [
                  CategoryNode('Duffle coats'),
                  CategoryNode('Faux fur coats'),
                  CategoryNode('Overcoats & long coats'),
                  CategoryNode('Parkas'),
                  CategoryNode('Raincoats'),
                  CategoryNode('Trench coats'),
                  CategoryNode('Sports coats'),
                ],
              ),
              CategoryNode('Body warmers'),
              CategoryNode('Capes & ponchos'),
            ],
          ),
          CategoryNode(
            'Jumpers & sweaters',
            children: [
              CategoryNode('Hoodies'),
              CategoryNode('Jumpers'),
              CategoryNode('Cardigans'),
              CategoryNode('Zip-through hoodies & sweaters'),
              CategoryNode('Sweaters'),
            ],
          ),
          CategoryNode(
            'Suits & blazers',
            children: [
              CategoryNode('Blazers'),
              CategoryNode('Trouser suits'),
              CategoryNode('Wedding suits'),
              CategoryNode('Waistcoats'),
              CategoryNode('Suits sets'),
              CategoryNode('Other suits & blazers'),
            ],
          ),
          CategoryNode(
            'Tops & t-shirts',
            children: [
              CategoryNode(
                'Shirts',
                children: [
                  CategoryNode('Checked shirts'),
                  CategoryNode('Denim shirts'),
                  CategoryNode('Plain shirts'),
                  CategoryNode('Striped shirts'),
                  CategoryNode('Print shirts'),
                  CategoryNode('Other shirts'),
                ],
              ),
              CategoryNode('T-shirts'),
              CategoryNode('Vest & sleeveless tops'),
              CategoryNode('Other tops & t-shirts'),
            ],
          ),
          CategoryNode(
            'Jeans',
            children: [
              CategoryNode('Ripped jeans'),
              CategoryNode('Skinny jeans'),
              CategoryNode('Slim fit jeans'),
              CategoryNode('Straight jeans'),
              CategoryNode('Others jeans'),
            ],
          ),
          CategoryNode(
            'Trousers',
            children: [
              CategoryNode('Cropped trousers'),
              CategoryNode('Chinos'),
              CategoryNode('Wide-leg trousers'),
              CategoryNode('Skinny trousers'),
              CategoryNode('Tailored trousers'),
              CategoryNode('Straight trousers'),
              CategoryNode('Leather trousers'),
              CategoryNode('Other trousers'),
            ],
          ),
          CategoryNode(
            'Shorts',
            children: [
              CategoryNode('Denim shorts'),
              CategoryNode('Cargo shorts'),
              CategoryNode('Chino trousers'),
              CategoryNode('Other shorts & cropped trousers'),
            ],
          ),
          CategoryNode('Swimwear'),
          CategoryNode(
            'Sleepwear',
            children: [
              CategoryNode('Pyjama sets'),
              CategoryNode('Pyjama bottoms'),
              CategoryNode('Pyjama tops'),
              CategoryNode('One-piece pyjama'),
            ],
          ),
          CategoryNode(
            'Socks & underwear',
            children: [
              CategoryNode('Underwear'),
              CategoryNode('Socks'),
              CategoryNode('Other socks & underwear'),
            ],
          ),
          CategoryNode(
            'Activewear',
            children: [
              CategoryNode('Outerwear'),
              CategoryNode('Tracksuits'),
              CategoryNode('Trousers'),
              CategoryNode('Shorts'),
              CategoryNode('Tops & t-shirts'),
              CategoryNode('Jerseys'),
              CategoryNode('Hoodies & sweatshirts'),
              CategoryNode(
                'Sports accessories',
                children: [
                  CategoryNode('Glasses'),
                  CategoryNode('Gloves'),
                  CategoryNode('Sports caps'),
                  CategoryNode('Wristbands'),
                  CategoryNode('Other sports accessories'),
                ],
              ),
              CategoryNode('Other activewears'),
            ],
          ),
          CategoryNode('Costumes & special outfits'),
          CategoryNode("Other men's clothing"),
        ],
        //clothingChildren,
        //children: clothingChildren,
      ),
      CategoryNode('Shoes', icon: Icons.directions_walk_outlined),
      CategoryNode('Bags', icon: Icons.shopping_bag_outlined),
      CategoryNode('Accessories', icon: Icons.watch_outlined),
      CategoryNode('Grooming', icon: Icons.brush_outlined),
    ],
  );

  const kids = CategoryNode(
    'Kids',
    icon: Icons.child_care_outlined,
    children: [
      CategoryNode("Girls' clothing", icon: Icons.checkroom_outlined),
      CategoryNode("Boys' clothing", icon: Icons.directions_walk_outlined),
      CategoryNode('Toys', icon: Icons.directions_walk_outlined),
      CategoryNode(
        'Pushchairs, car seats',
        icon: Icons.directions_walk_outlined,
      ),
      CategoryNode('Baby furniture', icon: Icons.directions_walk_outlined),
      CategoryNode('Bathing & changing', icon: Icons.directions_walk_outlined),
      CategoryNode('Health & pregnancy', icon: Icons.directions_walk_outlined),
      CategoryNode('Nursing & feeding', icon: Icons.directions_walk_outlined),
      CategoryNode('Sleep & bedding', icon: Icons.directions_walk_outlined),
      CategoryNode('School supplies', icon: Icons.directions_walk_outlined),
      CategoryNode('Other items', icon: Icons.directions_walk_outlined),
    ],
  );
  const home = CategoryNode('Home', icon: Icons.living_outlined);
  const electronics = CategoryNode(
    'Electronics',
    icon: Icons.power_settings_new,
  );
  const entertainment = CategoryNode(
    'Entertainment',
    icon: Icons.menu_book_outlined,
  );
  const hobbies = CategoryNode(
    'Hobbies & collectables',
    icon: Icons.star_border,
  );
  const sports = CategoryNode('Sports', icon: Icons.sports_baseball_outlined);

  return const CategoryNode(
    // The main list of categories
    'Root',
    children: [
      women,
      men,
      kids,
      home,
      electronics,
      entertainment,
      hobbies,
      sports,
    ],
  );
}

/// ---------------------------------------------------------------------------
/// Root: “Category” page (Women, Men, Kids, …) with optional initial path
/// ---------------------------------------------------------------------------
class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    this.initialPath = const [], // e.g. ['Women'] or ['Women','Clothing']
  });

  /// Labels from root to where you want to start.
  final List<String> initialPath;

  @override
  Widget build(BuildContext context) {
    final root = _buildRootTree();

    // Descend the tree following initialPath (if provided)
    CategoryNode node = root;
    for (final label in initialPath) {
      final next = node.children.firstWhere(
        (c) => c.label == label,
        orElse: () => node, // stop if not found
      );
      if (identical(next, node)) break;
      node = next;
    }

    final title = initialPath.isEmpty ? 'Category' : initialPath.last;
    return _CategoryLevelPage(
      title: title,
      nodes: node.children,
      path: initialPath,
    );
  }
}

/// ---------------------------------------------------------------------------
/// Generic level page: shows a list of [nodes] with search & navigation
/// ---------------------------------------------------------------------------
class _CategoryLevelPage extends StatefulWidget {
  const _CategoryLevelPage({
    required this.title,
    required this.nodes,
    required this.path,
  });

  final String title;
  final List<CategoryNode> nodes;
  final List<String> path;

  @override
  State<_CategoryLevelPage> createState() => _CategoryLevelPageState();
}

class _CategoryLevelPageState extends State<_CategoryLevelPage> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchCtrl.text.trim().toLowerCase();
    final filtered = query.isEmpty
        ? widget.nodes
        : widget.nodes
              .where((n) => n.label.toLowerCase().contains(query))
              .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Find a category',
                prefixIcon: Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final node = filtered[i];
                return ListTile(
                  leading: node.icon == null ? null : Icon(node.icon),
                  title: Text(node.label),
                  trailing: node.isLeaf
                      ? const Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.grey,
                        )
                      : const Icon(Icons.chevron_right),
                  onTap: () async {
                    if (node.isLeaf) {
                      // Return a CategoryPick directly
                      final labels = [...widget.path, node.label];
                      Navigator.pop(context, CategoryPick(labels));
                    } else {
                      // Go one level deeper and WAIT for a result
                      final pick = await Navigator.push<CategoryPick>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => _CategoryLevelPage(
                            title: node.label,
                            nodes: node.children,
                            path: [...widget.path, node.label],
                          ),
                        ),
                      );

                      // If a deeper level returned a pick, bubble it up
                      if (pick != null && context.mounted) {
                        Navigator.pop(context, pick);
                      }
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
