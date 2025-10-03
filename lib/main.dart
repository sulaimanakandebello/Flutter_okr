// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'services/auth_service.dart';
import 'services/products_repository.dart';
import 'services/fake_products_repository.dart'; // dev/local data
import 'data/firebase_products_repository.dart'; // real Firestore data

import 'state/app_state.dart';
import 'app_shell.dart';
import 'pages/sign_in_page.dart';
import 'pages/intro_splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Toggle this (or use a dart-define) to swap data sources.
  const bool useFirebaseRepo = false; // set true once Firestore is ready

  final ProductsRepository repo =
      useFirebaseRepo ? FirebaseProductsRepository() : FakeProductsRepository();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<ProductsRepository>.value(value: repo),
        ChangeNotifierProvider<AppState>(
          create: (ctx) => AppState(repo: ctx.read<ProductsRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();

    return MaterialApp(
      title: 'Okrika',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      // Splash first, then auth-gated routing
      home: FutureBuilder(
        future: Future<void>.delayed(const Duration(milliseconds: 1200)),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const IntroSplashScreen();
          }
          // After splash, show SignIn or AppShell based on auth state
          return StreamBuilder(
            stream: auth.authStateChanges(),
            builder: (context, AsyncSnapshot userSnap) {
              if (userSnap.connectionState == ConnectionState.waiting) {
                return const IntroSplashScreen();
              }
              if (userSnap.hasData) {
                // ✅ All pages (including HomePage) are under the providers above
                return const AppShell();
              }
              return const SignInPage();
            },
          );
        },
      ),
    );
  }
}
