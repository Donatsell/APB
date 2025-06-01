import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'profil_base_screen.dart';
import '../../helpers/navigation_helpers.dart';

class ProfileStudentScreen extends StatefulWidget {
  const ProfileStudentScreen({super.key});

  @override
  State<ProfileStudentScreen> createState() => _ProfileStudentScreenState();
}

class _ProfileStudentScreenState extends State<ProfileStudentScreen> {
  // Firebase refs
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // ----- state data -----
  String avatarUrl = 'https://www.gravatar.com/avatar/placeholder?s=150&d=mp';
  String name = '';
  String email = '';
  int completed = 0;
  int totalCourse = 0;
  String totalTime = '0j 0m';
  String streak = '0 hari';

  bool _loading = true;

  // ---------- life-cycle ----------
  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  // ---------- load profile ----------
  Future<void> _fetchProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final snap = await _firestore.collection('users').doc(user.uid).get();
      final data = snap.data();
      if (data != null) {
        setState(() {
          name = data['name'] ?? '';
          email = data['email'] ?? user.email ?? '';
          avatarUrl = data['avatarUrl'] ?? avatarUrl;
          completed = data['coursesCompleted'] ?? 0;
          totalCourse = data['totalCourses'] ?? 0;
          totalTime = data['totalTime'] ?? '0j 0m';
          streak = data['streak'] ?? '0 hari';
          _loading = false;
        });
      }
    } catch (e) {
      debugPrint('🔥 fetch profile failed: $e');
    }
  }

  // ---------- kamera / galeri ----------
  Future<void> _changeAvatar() async {
    final picker = ImagePicker();
    final pick = await picker.pickImage(
      source: ImageSource.camera, // → ImageSource.gallery jika perlu
      maxWidth: 600,
    );
    if (pick == null) return;

    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // upload ke Storage
      final ref = FirebaseStorage.instance.ref('avatars/${user.uid}.jpg');
      await ref.putFile(File(pick.path));
      final url = await ref.getDownloadURL();

      // simpan di Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'avatarUrl': url,
      });

      setState(() => avatarUrl = url);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Foto profil diperbarui')));
      }
    } catch (e) {
      debugPrint('🔥 avatar upload error: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal mengganti foto')));
      }
    }
  }

  // ---------- bottom-nav ----------
  void _onTab(int i) {
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

  // ---------- menu list ----------
  void _onMenu(String id) {
    if (id == 'Ganti Foto') {
      _changeAvatar();
      return;
    }
    // menu lainnya
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Menu "$id" belum tersedia')));
  }

  // ---------- BUILD ----------
  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return ProfileBaseScreen(
      // data
      avatarUrl: avatarUrl,
      name: name,
      email: email,
      coursesCompleted: completed,
      totalCourses: totalCourse,
      totalTime: totalTime,
      streak: streak,
      // callback
      currentTab: 3,
      onTabSelect: _onTab,
      onMenuTap: _onMenu,
    );
  }
}
