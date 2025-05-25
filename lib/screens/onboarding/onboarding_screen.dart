import 'package:flutter/material.dart';
import '../../models/onboarding_data.dart';
import '../../widgets/onboarding_page.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Selamat Datang di CodeQuest',
      description: "Temukan cara baru belajar coding dengan cara menyenangkan.",
      image: 'assets/images/onboarding1.png',
    ),
    OnboardingData(
      title: 'Belajar Interaktif',
      description:
          "Latihan langsung, quiz, dan tantangan untuk mengasah kemampuanmu.",
      image: 'assets/images/onboarding2.png',
    ),
    OnboardingData(
      title: 'Capai Mimpimu',
      description:
          "Mulai perjalanan coding-mu dan raih tujuan karier impianmu.",
      image: 'assets/images/onboarding3.png',
    ),
  ];

  void _nextPage() {
    if (_currentIndex == _pages.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _backPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: _pages.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) {
          return OnboardingPage(
            data: _pages[index],
            isLast: index == _pages.length - 1,
            onNext: _nextPage,
            onBack: _backPage,
          );
        },
      ),
    );
  }
}
