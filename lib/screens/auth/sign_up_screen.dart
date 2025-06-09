// lib/screens/auth/sign_up_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apb_ta_new/screens/auth/auth_services.dart';
import 'package:apb_ta_new/models/auth_data.dart';
import 'package:apb_ta_new/screens/success/success_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();

  String _role = 'student'; // ⬅️ dropdown
  bool _loading = false;

  // ─────────── EMAIL / PASSWORD ───────────
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      // 1. daftar di Firebase Auth
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailC.text.trim(),
        password: _passC.text.trim(),
      );

      // 2. simpan ke Firestore
      final user = cred.user;
      if (user != null) {
        await user.updateDisplayName(_nameC.text.trim());
        await saveUserData(user, _nameC.text.trim(), role: _role);
      }

      // 3. tampilkan layar sukses
      _openSuccess(
        title: 'Registrasi Berhasil!',
        message: 'Silakan login untuk mulai belajar.',
      );
    } on FirebaseAuthException catch (e) {
      var msg = switch (e.code) {
        'email-already-in-use' => 'Email sudah terdaftar',
        'weak-password' => 'Password terlalu lemah',
        _ => 'Registrasi gagal',
      };
      _showSnack(msg);
    } finally {
      setState(() => _loading = false);
    }
  }

  // ─────────── GOOGLE ───────────
  Future<void> _signUpWithGoogle() async {
    setState(() => _loading = true);
    try {
      final cred = await AuthService().signInWithGoogle();
      if (cred == null) throw FirebaseAuthException(code: 'canceled');

      // user baru? simpan data + default role = student
      if (cred.additionalUserInfo?.isNewUser ?? false) {
        await saveUserData(
          cred.user!,
          cred.user!.displayName ?? 'Pengguna',
          role: _role, // gunakan role dari dropdown
        );
      }

      _openSuccess(
        title: 'Google Sign-In Sukses',
        message: 'Akun Anda siap digunakan. Silakan login.',
      );
    } on FirebaseAuthException catch (e) {
      _showSnack(e.message ?? 'Login Google dibatalkan');
    } finally {
      setState(() => _loading = false);
    }
  }

  // ─────────── UI ───────────
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Daftar'),
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Buat Akun Baru',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // Nama
              _field(
                _nameC,
                'Nama Lengkap',
                validator:
                    (v) =>
                        (v == null || v.trim().isEmpty)
                            ? 'Nama wajib diisi'
                            : null,
              ),
              const SizedBox(height: 16),

              // Email
              _field(
                _emailC,
                'Email',
                keyboard: TextInputType.emailAddress,
                validator:
                    (v) =>
                        (v == null || !v.contains('@'))
                            ? 'Email tidak valid'
                            : null,
              ),
              const SizedBox(height: 16),

              // Password
              _field(
                _passC,
                'Kata Sandi',
                obscure: true,
                validator:
                    (v) =>
                        (v != null && v.length < 6) ? 'Min. 6 karakter' : null,
              ),
              const SizedBox(height: 16),

              // Role
              DropdownButtonFormField<String>(
                value: _role,
                decoration: _dec('Daftar sebagai'),
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Siswa')),
                  DropdownMenuItem(value: 'mentor', child: Text('Mentor')),
                ],
                onChanged: (v) => setState(() => _role = v ?? 'student'),
              ),
              const SizedBox(height: 24),

              // Tombol DAFTAR
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _register,
                  child:
                      _loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('DAFTAR'),
                ),
              ),
              const SizedBox(height: 16),

              const Row(
                children: [
                  Expanded(child: Divider()),
                  Text('  atau  '),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: _loading ? null : _signUpWithGoogle,
                icon: Image.asset('assets/icons/Google.png', height: 24),
                label: const Text('Daftar dengan Google'),
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah punya akun? '),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Masuk',
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

  // ─────────── helper ───────────
  TextFormField _field(
    TextEditingController c,
    String label, {
    String? hint,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) => TextFormField(
    controller: c,
    obscureText: obscure,
    keyboardType: keyboard,
    validator: validator,
    decoration: _dec(label).copyWith(hintText: hint),
  );

  InputDecoration _dec(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  void _showSnack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  void _openSuccess({required String title, required String message}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) => SuccessScreen(
              title: title,
              message: message,
              buttonText: 'MASUK',
              routeAfter: '/login',
            ), 
      ), 
    );
  }

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }
}
