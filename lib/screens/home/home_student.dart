import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_base_screen.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  // ----- kursus contoh -----
  static const _recommended = [
    {
      'title': 'Flutter untuk Pemula',
      'rating': 4.8,
      'duration': '8 j',
      'icon': Icons.mobile_friendly,
    },
    {
      'title': 'Dasar-dasar UI/UX',
      'rating': 4.7,
      'duration': '6 j 30 m',
      'icon': Icons.design_services,
    },
    {
      'title': 'JavaScript Mahir',
      'rating': 4.9,
      'duration': '12 j',
      'icon': Icons.code,
    },
  ];

  // ----- helper navigasi -----
  void _toMyCourse(BuildContext ctx) =>
      Navigator.pushNamed(ctx, '/choose-course');
  void _toBlogs(BuildContext ctx) => Navigator.pushNamed(ctx, '/blogs');
  void _toProfile(BuildContext ctx) => Navigator.pushNamed(ctx, '/profile');
  void _toCourseDetail(BuildContext ctx, Map<String, dynamic> c) =>
      Navigator.pushNamed(ctx, '/course-detail', arguments: c);

  @override
  Widget build(BuildContext context) {
    final nama = FirebaseAuth.instance.currentUser?.displayName ?? 'Siswa';

    return HomeBaseScreen(
      greeting: 'Hai, $nama 👋',
      courses: _recommended,
      onProfileTap: () => _toProfile(context),
      onCourseTap: (c) => _toCourseDetail(context, c),
      onCourseTabTap: () => _toMyCourse(context),
      onBlogTabTap: () => _toBlogs(context),
      selectedChip: 'Disarankan',
      chipLabels: const ['Disarankan', 'Desain', 'Pemrograman', 'UI/UX'],
      promoCard: _promoCard(),
    );
  }

  /// Kartu promo sederhana
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
          'Belajar Berbasis Proyek 🔥\nDaftar sekarang!',
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
