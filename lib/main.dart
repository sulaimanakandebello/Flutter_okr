/*
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_okr/pages/intro_splashscreen.dart';
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
      //home: const AppShell(),
      home: const IntroSplashScreen(), // 👈 start here
      routes: {
        '/shell': (_) => const AppShell(),
      },
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Firebase only when enabled
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_okr/pages/intro_splashscreen.dart';

import 'state/app_state.dart';
import 'services/products_repository.dart';
import 'services/fake_products_repository.dart';
import 'data/firebase_products_repository.dart'; // <-- adjust path if yours differs
import 'app_shell.dart';

// Flip at build time: --dart-define=USE_FIREBASE=true
const kUseFirebase = bool.fromEnvironment('USE_FIREBASE', defaultValue: false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late final ProductsRepository repo;

  if (kUseFirebase) {
    // Init Firebase only when requested
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    repo = FirebaseProductsRepository();
  } else {
    repo = FakeProductsRepository();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState(repo: repo)),
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
      //home: const AppShell(), // hosts the bottom nav
      home: const IntroSplashScreen(), // 👈 start here
      routes: {
        '/shell': (_) => const AppShell(),
      },
    );
  }
}
