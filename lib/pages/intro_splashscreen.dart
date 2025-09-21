import 'package:flutter/material.dart';
import 'package:flutter_okr/app_shell.dart';

class IntroSplashScreen extends StatefulWidget {
  const IntroSplashScreen({super.key});

  @override
  State<IntroSplashScreen> createState() => _IntroSplashScreenState();
}

class _IntroSplashScreenState extends State<IntroSplashScreen> {
  double _opacity = 1.0;
  bool _didNavigate = false;

  @override
  void initState() {
    super.initState();
    // Wait 2s, then start fading out the splash content.
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _opacity = 0);
    });
  }

  void _goNext() {
    if (_didNavigate || !mounted) return;
    _didNavigate = true;
    Navigator.of(context).pushReplacementNamed('/shell');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: AnimatedOpacity(
        opacity: _opacity, // 1 → 0 triggers fade-out
        duration: const Duration(milliseconds: 500),
        onEnd: () {
          if (_opacity == 0) _goNext(); // navigate exactly once
        },
        child: const Center(
          child: Text(
            'OKRIKA!',
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
