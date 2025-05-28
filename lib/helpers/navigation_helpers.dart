import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_data.dart';

/// Navigasi otomatis ke home berdasarkan peran pengguna
Future<void> navigateToHomeBasedOnRole(BuildContext context, User user) async {
  final role = await getUserRole(user);
  final route = role == 'mentor' ? '/home-mentors' : '/home-student';
  Navigator.pushReplacementNamed(context, route);
}

/// Shortcut: ke layar Kursus Saya
void openMyCourseScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/my-courses');

/// Shortcut: ke layar Blog
void openBlogsScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/blogs');

/// Shortcut: ke layar Profil
void openProfileScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/profile');

/// Navigasi ke detail kursus, dengan membawa argumen
void openCourseDetailScreen(
  BuildContext context,
  Map<String, dynamic> course,
) => Navigator.pushNamed(context, '/course-detail', arguments: course);

/// Navigasi ke layar blog utama (dipakai bottom-nav blogger)
void openBlogScreen(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/blogs');
