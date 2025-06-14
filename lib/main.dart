// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

// splash & onboarding
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';

// auth
import 'screens/auth/login_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/auth/forgot_password_screen.dart';

// success
import 'screens/success/success_screen.dart';

// home
import 'screens/home/home_screen.dart';
import 'screens/home/home_student.dart';
import 'screens/home/home_mentors.dart';

// fitur siswa
import 'screens/myCourse/course_student.dart';
import 'screens/blogger/blogger_student.dart';
import 'screens/profil/profil_student.dart';

// fitur mentor
import 'screens/myCourse/course_mentor.dart';

Future<void> _initFirestore() async {
  // 1) atur cache – aktif by default, tapi kita set eksplisit + unlimited.
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // 2) pastikan client online (misalnya app sebelumnya force-offline)
  await FirebaseFirestore.instance.enableNetwork();
  //  > kalau ingin force-offline di dev:
  //  await FirebaseFirestore.instance.disableNetwork();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await _initFirestore(); // 🔌 online / offline setup

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
        // splash & onboarding
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),

        // auth
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/success': (_) => const SuccessScreen(),

        // home (guest + role-based)
        '/home': (_) => const HomeScreen(), // guest
        '/home-student': (_) => HomeStudentScreen(),
        '/home-mentors': (_) => HomeMentorScreen(),

        // siswa: kursus, blog, profil
        '/choose-course': (_) => CourseStudentScreen(),
        '/blogs': (_) => const BloggerStudentScreen(),
        '/profile': (_) => const ProfileStudentScreen(),

        // mentor: profil, kursus saya, detail kursus
        '/mentor-my-courses': (_) => CoursesMentorScreen(),
      },
    );
  }
}
