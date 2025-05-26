// lib/screens/home/home_student.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_base_screen.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  static const _recommendCourse = [
    {
      'title': 'Flutter for Beginners',
      'rating': 4.8,
      'duration': '8h',
      'icon': Icons.mobile_friendly,
    },
    {
      'title': 'UI/UX Fundamentals',
      'rating': 4.7,
      'duration': '6h 30m',
      'icon': Icons.design_services,
    },
    {
      'title': 'JavaScript Mastery',
      'rating': 4.9,
      'duration': '12h',
      'icon': Icons.code,
    },
  ];

  // ---------- navigation helpers ----------
  void _openMyCourse(BuildContext ctx) =>
      Navigator.pushNamed(ctx, '/choose-course'); // ✅ singular
  void _openBlogs(BuildContext ctx) => Navigator.pushNamed(ctx, '/blogs');
  void _openProfile(BuildContext ctx) => Navigator.pushNamed(ctx, '/profile');
  void _openCourseDetail(BuildContext ctx, Map<String, dynamic> c) =>
      Navigator.pushNamed(ctx, '/course-detail', arguments: c);

  @override
  Widget build(BuildContext context) {
    final name = FirebaseAuth.instance.currentUser?.displayName ?? 'Student';

    return HomeBaseScreen(
      greeting: 'Hi, $name 👋',
      courses: _recommendCourse,
      onProfileTap: () => _openProfile(context),
      onCourseTap: (c) => _openCourseDetail(context, c),
      onCourseTabTap: () => _openMyCourse(context), // ✅
      onBlogTabTap: () => _openBlogs(context),
      selectedChip: 'Recommended',
      chipLabels: const ['Recommended', 'Design', 'Programming', 'UI/UX'],
      promoCard: _promoCard(),
    );
  }

  /// kartu promo
  Widget _promoCard() => Container(
    height: 140,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        colors: [Color(0xFF9333EA), Color(0xFF6D28D9)],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    ),
    child: const Padding(
      padding: EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Project-Based Learning 🔥\nEnroll now!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
