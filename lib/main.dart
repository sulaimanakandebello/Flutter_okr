/*

// lib/main.dart
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'state/app_state.dart';

// Repositories
import 'services/products_repository.dart';
import 'services/fake_products_repository.dart';
import 'data/firebase_products_repository.dart';

// UI
import 'app_shell.dart';
import 'pages/intro_splashscreen.dart';

/// Compile-time flag:
///   - Fake repo (default):  flutter run
///   - Firebase repo:        flutter run --dart-define=USE_FIREBASE=true
const bool kUseFirebase = bool.fromEnvironment('USE_FIREBASE');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase is safe to init in both modes (Fake or Firebase).
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Make sure we always have a UID (use anonymous auth).
  // If you prefer only when using Firebase, guard with `if (kUseFirebase)`.
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } catch (_) {
    // If this ever fails (e.g., emulator w/o network), the app still runs.
  }

  // Choose repo based on flag
  final ProductsRepository repo =
      kUseFirebase ? FirebaseProductsRepository() : FakeProductsRepository();

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

      // Start on Splash
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const IntroSplashScreen(),
        '/shell': (_) => const AppShell(), // your bottom-nav host
      },
    );
  }
}
*/

/*
// lib/main.dart
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'services/auth_service.dart';

// Repositories
import 'services/products_repository.dart';
import 'services/fake_products_repository.dart';
import 'data/firebase_products_repository.dart';

// UI
import 'app_shell.dart';
import 'pages/intro_splashscreen.dart';

/// Compile-time flag:
///   - Fake repo (default):  flutter run
///   - Firebase repo:        flutter run --dart-define=USE_FIREBASE=true
const bool kUseFirebase = bool.fromEnvironment('USE_FIREBASE');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase is safe to init in both modes (Fake or Firebase).
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Make sure we always have a UID (use anonymous auth).
  // If you prefer only when using Firebase, guard with `if (kUseFirebase)`.
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } catch (_) {
    // If this ever fails (e.g., emulator w/o network), the app still runs.
  }

  // Choose repo based on flag
  final ProductsRepository repo =
      kUseFirebase ? FirebaseProductsRepository() : FakeProductsRepository();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()),
        // your AppState provider here...
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

      // Start on Splash
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const IntroSplashScreen(),
        '/shell': (_) => const AppShell(), // your bottom-nav host
      },
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';
import 'app_shell.dart';
import 'pages/sign_in_page.dart';
import 'pages/intro_splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const OkrikaApp());
}

class OkrikaApp extends StatelessWidget {
  const OkrikaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        // Add other providers (e.g., AppState) here if you want them global.
      ],
      child: MaterialApp(
        title: 'Okrika',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.teal,
        ),
        home: const _AuthGate(),
      ),
    );
  }
}

/// Decides which page to show based on FirebaseAuth state.
/// Shows SplashScreen while the auth stream is connecting.
class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snap) {
        // Still connecting (first app boot) → Splash
        if (snap.connectionState == ConnectionState.waiting) {
          return const IntroSplashScreen();
        }

        // Signed in → AppShell
        if (snap.hasData) {
          return const AppShell();
        }

        // Not signed in → SignInPage
        return const SignInPage();
      },
    );
  }
}
