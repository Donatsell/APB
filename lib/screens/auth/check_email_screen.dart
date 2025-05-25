import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  Future<void> _launchEmailApp(BuildContext context) async {
    final Uri emailUri = Uri(scheme: 'mailto');

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka aplikasi email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 16),

              // Konten utama
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/email_sent.png',
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 32),

                        const Text(
                          "Cek Email Anda",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        const Text(
                          "Kami telah mengirim tautan untuk mengatur ulang kata sandi Anda. Silakan buka email Anda untuk melanjutkan.",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // Tombol buka email
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _launchEmailApp(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("BUKA EMAIL"),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Kembali ke login
                        TextButton(
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName('/login'),
                            );
                          },
                          child: const Text(
                            "Kembali ke Masuk",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
