// lib/app_shell.dart
import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/sell_page.dart';
import 'pages/inbox_page.dart';
import 'pages/profile_page.dart';

/// Expose current tab + setter so children can switch tabs without pushing routes.
class AppShellScope extends InheritedWidget {
  final int index;
  final void Function(int) setIndex;
  const AppShellScope({
    super.key,
    required this.index,
    required this.setIndex,
    required super.child,
  });

  static AppShellScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppShellScope>();
    assert(scope != null, 'No AppShellScope found in the widget tree.');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppShellScope oldWidget) => index != oldWidget.index;
}

class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _index = widget.initialIndex;

  // Keep scroll positions per tab.
  final _bucket = PageStorageBucket();

  // 5 tabs; Sell (index 2) is special (we push it modally).
  final _pages = const [
    HomePage(key: PageStorageKey('home')),
    SearchPage(key: PageStorageKey('search')),
    SizedBox.shrink(), // index 2 reserved for Sell
    InboxPage(key: PageStorageKey('inbox')),
    ProfilePage(key: PageStorageKey('profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShellScope(
      index: _index,
      setIndex: (i) => setState(() => _index = i),
      child: Scaffold(
        body: PageStorage(
          bucket: _bucket,
          child: IndexedStack(
            index: _index == 2 ? 0 : (_index > 2 ? _index - 1 : _index),
            children: const [
              HomePage(),
              SearchPage(),
              InboxPage(),
              ProfilePage(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          onTap: (i) {
            if (i == 2) {
              // SELL → push on top; don’t change the selected tab.
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SellPage()));
              return;
            }
            setState(() => _index = i);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline), label: 'Sell'),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline), label: 'Inbox'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
