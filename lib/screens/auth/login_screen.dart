// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apb_ta_new/screens/auth/auth_services.dart';
import 'package:apb_ta_new/models/auth_data.dart';
import '../../helpers/navigation_helpers.dart'; // ✅ helper umum

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  bool _loading = false;

  // ──────────────── EMAIL / PASSWORD ────────────────
  Future<void> _login() async {
    final email = _emailC.text.trim();
    final pass = _passC.text;

    if (email.isEmpty || pass.isEmpty) {
      _showSnack('Email dan kata sandi tidak boleh kosong');
      return;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showSnack('Format email tidak valid');
      return;
    }

    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      // ➜ arahkan sesuai role
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) await navigateToHomeBasedOnRole(context, user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        _showSnack(
          'Email atau kata sandi salah.',
          action: SnackBarAction(
            label: 'Reset Sandi',
            textColor: Colors.yellow,
            onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
          ),
        );
      } else {
        _showSnack(e.message ?? 'Login gagal');
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  // ──────────────── GOOGLE ────────────────
  Future<void> _loginWithGoogle() async {
    final cred = await AuthService().signInWithGoogle();
    if (cred == null) {
      _showSnack('Login Google gagal');
      return;
    }

    final isNew = cred.additionalUserInfo?.isNewUser ?? false;
    final user = cred.user!;
    if (isNew) await saveUserData(user, user.displayName ?? 'Pengguna');

    _showSnack(
      isNew ? 'Akun baru dibuat dengan Google!' : 'Login Google berhasil',
    );

    await navigateToHomeBasedOnRole(context, user);
  }

  // ──────────────── UI ────────────────
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading:
          Navigator.canPop(context)
              ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
              : null,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat Datang Kembali',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Silakan masuk untuk melanjutkan',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Email
              _field(
                _emailC,
                'Email',
                hint: 'Email',
                keyboard: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password
              _field(_passC, 'Kata Sandi', hint: 'Kata Sandi', obscure: true),
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed:
                      () => Navigator.pushNamed(context, '/forgot-password'),
                  child: const Text('Lupa kata sandi?'),
                ),
              ),
              const SizedBox(height: 16),

              // Tombol MASUK
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('MASUK'),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('atau'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),

              // Google Login
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _loginWithGoogle,
                  icon: Image.asset(
                    'assets/icons/Google.png',
                    height: 24,
                    width: 24,
                  ),
                  label: const Text('Masuk dengan Google'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // ───────────── helper kecil ─────────────
  TextField _field(
    TextEditingController c,
    String label, {
    String? hint,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) => TextField(
    controller: c,
    obscureText: obscure,
    keyboardType: keyboard,
    autofillHints: [
      if (obscure) AutofillHints.password else AutofillHints.email,
    ],
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  void _showSnack(String msg, {SnackBarAction? action}) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(msg), action: action));
}
