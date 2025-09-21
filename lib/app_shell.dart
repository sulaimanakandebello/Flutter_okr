// lib/app_shell.dart
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/sell_page.dart';
import 'pages/inbox_page.dart';
import 'pages/profile_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});
  final int initialIndex;

  /// Allow children to switch tabs: AppShell.of(context)?.setTab(…)
  static _AppShellState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppShellState>();

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index;
  final _bucket = PageStorageBucket();

  /// Call from children: AppShell.of(context)?.setTab(i);
  void setTab(int i) => setState(() => _index = i);

  // We keep state for 4 tabs in the stack (Sell opens modally)
  final List<Widget> _tabs = const [
    HomePage(key: PageStorageKey('tab_home')),
    SearchPage(key: PageStorageKey('tab_search')),
    InboxPage(key: PageStorageKey('tab_inbox')),
    ProfilePage(key: PageStorageKey('tab_profile')),
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  /// Map bottom-bar index (0..4) to our 4-tab stack (0..3).
  /// We omit the middle Sell tab (2) from the stack and open it modally.
  int get _stackIndex {
    if (_index == 2)
      return 0; // when Sell is tapped, body remains as current tab
    if (_index > 2) return _index - 1; // 3→2 (Inbox), 4→3 (Profile)
    return _index; // 0,1 map to 0,1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: IndexedStack(index: _stackIndex, children: _tabs),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: (i) {
          if (i == 2) {
            // SELL opens on top (no tab change)
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SellPage()));
            return;
          }
          setState(() => _index = i);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
