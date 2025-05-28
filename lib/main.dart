import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ⬅︎ Tambahkan ini

import 'firebase_options.dart';

// Splash & onboarding
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';

// Auth
import 'screens/auth/login_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/auth/forgot_password_screen.dart';

// Home variants
import 'screens/home/home_screen.dart';
import 'screens/home/home_student.dart';
import 'screens/home/home_mentors.dart';

// Success
import 'screens/success/success_screen.dart';

// My-course
import 'screens/myCourse/course_student.dart';

// bloggers
import 'screens/blogger/blogger_student.dart';

// profil
import 'screens/profil/profil_student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 🔌 Aktifkan offline mode (default: true)
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true, // caching diaktifkan
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // 🌐 Pastikan client Firestore kembali online jika sempat offline
  await FirebaseFirestore.instance.enableNetwork();

  runApp(const CodeQuestApp());
}

class CodeQuestApp extends StatelessWidget {
  const CodeQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CodeQuest',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Poppins',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/success': (_) => const SuccessScreen(),

        // home-switcher (guest, student, mentor)
        '/home': (_) => const HomeScreen(),
        '/home-student': (_) => HomeStudentScreen(),
        '/home-mentors': (_) => HomeMentorScreen(),
        '/choose-course': (_) => CourseStudentScreen(),
        '/blogs': (_) => const BloggerStudentScreen(),
        '/profile': (_) => const ProfileStudentScreen(),
      },
    );
  }
}
