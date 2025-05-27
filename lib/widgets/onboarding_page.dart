import 'package:flutter/material.dart';
import '../../models/onboarding_data.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.isLast,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          children: [
            // Gambar responsif
            Expanded(
              flex: 4,
              child: Image.asset(
                data.image,
                width: size.width * 0.8,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Judul dan deskripsi
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Text(
                    data.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Tombol navigasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isLast)
                  TextButton(onPressed: onBack, child: const Text("Kembali"))
                else
                  const SizedBox(width: 80), // biar tombol kanan tetap kanan

                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Text(isLast ? "Mulai" : "Lanjut"),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
