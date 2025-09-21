/*
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_okr/app_shell.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';
import 'services/fake_products_repository.dart';
import 'state/app_state.dart';

// Pages
import 'pages/intro_splashscreen.dart';
import 'pages/home_page.dart';
import 'pages/search_page.dart';
import 'pages/sell_page.dart';
import 'pages/inbox_page.dart';
import 'pages/profile_page.dart';
import 'pages/product_page.dart';

void main() {
  runApp(const OkrikaApp());
}

class OkrikaApp extends StatelessWidget {
  const OkrikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(repo: const FakeProductsRepository()),
      child: MaterialApp(
        title: 'Okrika',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
          useMaterial3: true,
        ),

        // Start with the animated splash
        home: const IntroSplashScreen(),

        // Simple named routes for your main tabs
        routes: {
          '/shell': (_) => const AppShell(),
          '/home': (_) => const HomePage(),
          '/search': (_) => const SearchPage(),
          '/sell': (_) => const SellPage(),
          '/inbox': (_) => const InboxPage(),
          '/profile': (_) => const ProfilePage(),
        },

        // Use this when you need to push to ProductPage with an argument
        onGenerateRoute: (settings) {
          if (settings.name == '/product') {
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (_) => ProductPage(product: product),
            );
          }
          return null;
        },
      ),
    );
  }
}
*/

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app_shell.dart';
import 'state/app_state.dart';
import 'data/firebase_products_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Single instance of repo for the app
  final repo = FirebaseProductsRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AppState(repo: repo)..loadInitial()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okrika',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const AppShell(),
    );
  }
}
