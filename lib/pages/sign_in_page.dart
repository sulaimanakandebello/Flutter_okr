/*
// lib/pages/sign_in_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  bool _obscure = true;
  bool _isRegister = false;
  bool _busy = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleEmailSubmit() async {
    final auth = context.read<AuthService>();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;

    if (email.isEmpty || pass.length < 6) {
      _toast('Enter a valid email and a password (min 6 chars).');
      return;
    }

    setState(() => _busy = true);
    try {
      if (_isRegister) {
        await auth.signUpWithEmail(
          email: email,
          password: pass,
          displayName: _nameCtrl.text.trim().isEmpty ? null : _nameCtrl.text,
        );
      } else {
        await auth.signInWithEmail(email: email, password: pass);
      }
      // Stream in main.dart will navigate to AppShell automatically
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _handleGoogle() async {
    final auth = context.read<AuthService>();
    setState(() => _busy = true);
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _handleReset() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) {
      _toast('Enter your email first.');
      return;
    }
    final auth = context.read<AuthService>();
    setState(() => _busy = true);
    try {
      await auth.sendPasswordReset(email);
      _toast('Password reset email sent.');
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 16),
                Icon(Icons.storefront, size: 64, color: cs.primary),
                const SizedBox(height: 8),
                Text('Welcome to Okrika',
                    textAlign: TextAlign.center,
                    style:
                        t.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 24),
                if (_isRegister) ...[
                  Text('Display name', style: t.bodySmall),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'e.g. theslyman',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
                Text('Email', style: t.bodySmall),
                const SizedBox(height: 6),
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'you@example.com',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                Text('Password', style: t.bodySmall),
                const SizedBox(height: 6),
                TextField(
                  controller: _passCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    hintText: '******',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: _busy ? null : _handleEmailSubmit,
                    child: Text(_isRegister ? 'Create account' : 'Sign in'),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _busy ? null : _handleReset,
                  child: const Text('Forgot password?'),
                ),
                const SizedBox(height: 10),
                Row(children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or'),
                  ),
                  Expanded(child: Divider()),
                ]),
                const SizedBox(height: 10),
                SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: _busy ? null : _handleGoogle,
                    icon: const Icon(Icons.login),
                    label: const Text('Continue with Google'),
                  ),
                ),
                const SizedBox(height: 18),
                TextButton(
                  onPressed: _busy
                      ? null
                      : () => setState(() => _isRegister = !_isRegister),
                  child: Text(_isRegister
                      ? 'Have an account? Sign in'
                      : 'New here? Create an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/

/*
// lib/pages/sign_in_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  bool _obscure = true;
  bool _isRegister = false;
  bool _busy = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _handleEmailSubmit() async {
    FocusScope.of(context).unfocus();
    final auth = context.read<AuthService>();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;

    if (email.isEmpty || !email.contains('@')) {
      _toast('Please enter a valid email address.');
      return;
    }
    if (pass.length < 6) {
      _toast('Password must be at least 6 characters.');
      return;
    }

    setState(() => _busy = true);
    try {
      if (_isRegister) {
        await auth.signUpWithEmail(
          email: email,
          password: pass,
          displayName: _nameCtrl.text.trim().isEmpty ? null : _nameCtrl.text,
        );
      } else {
        await auth.signInWithEmail(email, pass);
      }
      // Navigation is handled by the auth stream in main.dart.
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _handleGoogle() async {
    FocusScope.of(context).unfocus();
    final auth = context.read<AuthService>();
    setState(() => _busy = true);
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _handleReset() async {
    FocusScope.of(context).unfocus();
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) {
      _toast('Enter your email first.');
      return;
    }
    final auth = context.read<AuthService>();
    setState(() => _busy = true);
    try {
      await auth.sendPasswordReset(email);
      _toast('Password reset email sent.');
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 16),
                Icon(Icons.storefront, size: 64, color: cs.primary),
                const SizedBox(height: 8),
                Text(
                  'Welcome to Okrika',
                  textAlign: TextAlign.center,
                  style: t.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),

                // Display name (register only)
                if (_isRegister) ...[
                  Text('Display name', style: t.bodySmall),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'e.g. theslyman',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !_busy,
                  ),
                  const SizedBox(height: 14),
                ],

                // Email
                Text('Email', style: t.bodySmall),
                const SizedBox(height: 6),
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'you@example.com',
                    border: OutlineInputBorder(),
                  ),
                  enabled: !_busy,
                ),
                const SizedBox(height: 14),

                // Password
                Text('Password', style: t.bodySmall),
                const SizedBox(height: 6),
                TextField(
                  controller: _passCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    hintText: '••••••',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      tooltip: _obscure ? 'Show' : 'Hide',
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _busy
                          ? null
                          : () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  enabled: !_busy,
                ),
                const SizedBox(height: 16),

                // Submit
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: _busy ? null : _handleEmailSubmit,
                    child: Text(_isRegister ? 'Create account' : 'Sign in'),
                  ),
                ),
                const SizedBox(height: 10),

                // Reset
                TextButton(
                  onPressed: _busy ? null : _handleReset,
                  child: const Text('Forgot password?'),
                ),
                const SizedBox(height: 10),

                // Divider
                Row(children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or'),
                  ),
                  Expanded(child: Divider()),
                ]),
                const SizedBox(height: 10),

                // Google
                SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: _busy ? null : _handleGoogle,
                    icon: const Icon(Icons.login),
                    label: const Text('Continue with Google'),
                  ),
                ),
                const SizedBox(height: 18),

                // Toggle register/sign in
                TextButton(
                  onPressed:
                      _busy ? null : () => setState(() => _isRegister = !_isRegister),
                  child: Text(
                    _isRegister
                        ? 'Have an account? Sign in'
                        : 'New here? Create an account',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/

// lib/pages/sign_in_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  bool _obscure = true;
  bool _isRegister = false;
  bool _busy = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleEmailSubmit() async {
    final auth = context.read<AuthService>();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;

    if (email.isEmpty || pass.length < 6) {
      _toast('Enter a valid email and a password (min 6 chars).');
      return;
    }

    setState(() => _busy = true);
    try {
      if (_isRegister) {
        await auth.signUpWithEmail(
          email: email,
          password: pass,
          displayName: _nameCtrl.text.trim().isEmpty ? null : _nameCtrl.text,
        );
      } else {
        await auth.signInWithEmail(email: email, password: pass);
      }
      // Navigation is handled by authStateChanges() listener in main.dart
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _handleGoogle() async {
    final auth = context.read<AuthService>();
    setState(() => _busy = true);
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _handleReset() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) {
      _toast('Enter your email first.');
      return;
    }
    final auth = context.read<AuthService>();
    setState(() => _busy = true);
    try {
      await auth.sendPasswordReset(email);
      _toast('Password reset email sent.');
    } catch (e) {
      _toast(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 16),
                Icon(Icons.storefront, size: 64, color: cs.primary),
                const SizedBox(height: 8),
                Text(
                  'Welcome to Okrika',
                  textAlign: TextAlign.center,
                  style: t.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),
                if (_isRegister) ...[
                  Text('Display name', style: t.bodySmall),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'e.g. theslyman',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
                Text('Email', style: t.bodySmall),
                const SizedBox(height: 6),
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'you@example.com',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                Text('Password', style: t.bodySmall),
                const SizedBox(height: 6),
                TextField(
                  controller: _passCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    hintText: '******',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: _busy ? null : _handleEmailSubmit,
                    child: Text(_isRegister ? 'Create account' : 'Sign in'),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _busy ? null : _handleReset,
                  child: const Text('Forgot password?'),
                ),
                const SizedBox(height: 10),
                Row(children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or'),
                  ),
                  Expanded(child: Divider()),
                ]),
                const SizedBox(height: 10),
                SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: _busy ? null : _handleGoogle,
                    icon: const Icon(Icons.login),
                    label: const Text('Continue with Google'),
                  ),
                ),
                const SizedBox(height: 18),
                TextButton(
                  onPressed: _busy
                      ? null
                      : () => setState(() => _isRegister = !_isRegister),
                  child: Text(_isRegister
                      ? 'Have an account? Sign in'
                      : 'New here? Create an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
