import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profil_base_screen.dart'; // Pastikan nama file benar
import '../../helpers/navigation_helpers.dart'; // Import helper navigasi

class ProfileStudentScreen extends StatefulWidget {
  const ProfileStudentScreen({super.key});

  @override
  State<ProfileStudentScreen> createState() => _ProfileStudentScreenState();
}

class _ProfileStudentScreenState extends State<ProfileStudentScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = '';
  String email = '';
  String avatarUrl =
      'https://www.gravatar.com/avatar/placeholder?s=150&d=mp'; // default
  int coursesCompleted = 0;
  int totalCourses = 0;
  String totalTime = '0j 0m';
  String streak = '0 hari';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _muatDataPengguna();
  }

  Future<void> _muatDataPengguna() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      final data = doc.data();

      if (data != null) {
        setState(() {
          name = data['name'] ?? '';
          email = data['email'] ?? user.email ?? '';
          avatarUrl = data['avatarUrl'] ?? avatarUrl;

          // Data opsional
          coursesCompleted = data['coursesCompleted'] ?? 0;
          totalCourses = data['totalCourses'] ?? 0;
          totalTime = data['totalTime'] ?? '0j 0m';
          streak = data['streak'] ?? '0 hari';

          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Gagal memuat data pengguna: $e');
    }
  }

  // Navigasi bottom tab
  void _pilihTab(BuildContext context, int i) {
    switch (i) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home-student');
        break;
      case 1:
        openMyCourseScreen(context);
        break;
      case 2:
        openBlogsScreen(context);
        break;
      case 3:
        openProfileScreen(context);
        break;
    }
  }

  // Aksi menu
  void _aksiMenu(BuildContext ctx, String id) {
    if (id == 'Edit Profile') {
      Navigator.pushNamed(context, '/edit-profile');
    } else {
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(SnackBar(content: Text('Diklik: $id')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return ProfileBaseScreen(
      avatarUrl: avatarUrl,
      name: name,
      email: email,
      coursesCompleted: coursesCompleted,
      totalCourses: totalCourses,
      totalTime: totalTime,
      streak: streak,
      currentTab: 3,
      onTabSelect: (i) => _pilihTab(context, i),
      onMenuTap: (id) => _aksiMenu(context, id),
    );
  }
}
