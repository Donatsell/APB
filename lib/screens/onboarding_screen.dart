import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Selamat Datang di CodeQuest",
      "description":
          "Temukan cara baru belajar coding dengan cara menyenangkan!",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "Belajar Interaktif",
      "description":
          "Latihan langsung, quiz, dan tantangan untuk mengasah kemampuanmu.",
      "image": "assets/images/onboarding2.png",
    },
    {
      "title": "Capai Mimpimu",
      "description":
          "Mulai perjalanan coding-mu dan raih tujuan karier impianmu.",
      "image": "assets/images/onboarding3.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: _onboardingData.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(_onboardingData[index]["image"]!, height: 300),
              const SizedBox(height: 40),
              Text(
                _onboardingData[index]["title"]!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _onboardingData[index]["description"]!,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (dotIndex) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: _currentIndex == dotIndex ? 12 : 8,
                    height: _currentIndex == dotIndex ? 12 : 8,
                    decoration: BoxDecoration(
                      color:
                          _currentIndex == dotIndex ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              if (index == _onboardingData.length - 1)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text("Mulai"),
                ),
            ],
          );
        },
      ),
    );
  }
}
