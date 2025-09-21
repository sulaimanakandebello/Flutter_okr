// lib/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_okr/app_shell.dart';
import 'package:flutter_okr/pages/category_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _jumpToTab(int i) => AppShell.of(context)?.setTab(i);

  @override
  Widget build(BuildContext context) {
    const items = <_TopCat>[
      _TopCat('Women', Icons.woman_outlined),
      _TopCat('Men', Icons.man_outlined),
      _TopCat('Designer', Icons.diamond_outlined),
      _TopCat('Kids', Icons.child_care_outlined),
      _TopCat('Home', Icons.living_outlined),
      _TopCat('Electronics', Icons.power_settings_new),
      _TopCat('Entertainment', Icons.menu_book_outlined),
      _TopCat('Hobbies & collectables', Icons.star_border),
      _TopCat('Sports', Icons.sports_baseball_outlined),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
            tooltip: 'Sell',
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => _jumpToTab(2), // open Sell tab from anywhere
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: items.length + 1, // search field + categories
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: TextField(
                controller: _searchCtrl,
                decoration: const InputDecoration(
                  hintText: 'Search for items or members',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (_) => setState(() {}),
              ),
            );
          }

          final cat = items[index - 1];
          return ListTile(
            leading: Icon(
              cat.icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(cat.label),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Jump directly into that branch in CategoryPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryPage(
                    initialPath: [
                      cat.label,
                    ], // e.g. ['Women'] -> shows Women’s children
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TopCat {
  final String label;
  final IconData icon;
  const _TopCat(this.label, this.icon);
}
