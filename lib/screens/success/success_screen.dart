// lib/screens/success/success_screen.dart
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final String routeAfter;

  const SuccessScreen({
    super.key,
    this.title = 'Successfully!',
    this.message = 'You can now login to your account',
    this.buttonText = 'GO TO LOGIN',
    this.routeAfter = '/login',
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 100, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed:
                () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  routeAfter,
                  (_) => false,
                ),
            child: Text(buttonText),
          ),
        ],
      ),
    ),
  );
}
