/*

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'services/fake_products_repository.dart'; // <-- use the file you have
import 'app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppState(repo: FakeProductsRepository()),
        ),
      ],
      child: const OkrikaApp(),
    ),
  );
}

class OkrikaApp extends StatelessWidget {
  const OkrikaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okrika',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const AppShell(), // bottom bar host
    );
  }
}
*/

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'services/products_repository.dart';
import 'services/fake_products_repository.dart';
import 'app_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Swap this to your real Firebase repo when ready:
  final ProductsRepository repo = FakeProductsRepository();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(repo: repo),
      child: const OkrikaApp(),
    ),
  );
}

class OkrikaApp extends StatelessWidget {
  const OkrikaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okrika',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const AppShell(),
    );
  }
}
