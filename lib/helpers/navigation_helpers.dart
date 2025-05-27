import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_data.dart';

/// Bawa pengguna ke beranda sesuai rolenya.
Future<void> navigateToHomeBasedOnRole(BuildContext context, User user) async {
  final role = await getUserRole(user);
  final route = role == 'mentor' ? '/home-mentors' : '/home-student';
  Navigator.pushReplacementNamed(context, route);
}

/// Shortcut buka layar “Kursus Saya”
void openMyCourseScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/my-courses');

/// Shortcut buka layar Blog
void openBlogsScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/blogs');

/// Shortcut buka layar Profil
void openProfileScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/profile');

/// Buka detail kursus, dengan argumen data kursus.
void openCourseDetailScreen(
  BuildContext context,
  Map<String, dynamic> course,
) => Navigator.pushNamed(context, '/course-detail', arguments: course);

/// Buka layar blog (digunakan di bottom-nav Blogger)
void openBlogScreen(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/blogs');
