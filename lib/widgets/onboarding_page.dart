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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.image, height: 250),
          const SizedBox(height: 32),
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(),
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isLast)
                TextButton(
                  onPressed: onBack,
                  child: const Text("Back"),
                )
              // Wrapping the ElevatedButton in a Row to move it to the right
              else

                const SizedBox(), // agar posisi button kanan tetap di ujung

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(isLast ? "Mulai" : "Lanjut"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
