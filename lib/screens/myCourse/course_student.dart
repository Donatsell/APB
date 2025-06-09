import 'package:flutter/material.dart';
import 'course_base_screen.dart';

/// Halaman *Pilih Kursus* (khusus Siswa)
class CourseStudentScreen extends StatelessWidget {
  const CourseStudentScreen({super.key});

  /// Data contoh (bisa diganti API / Firestore)
  static const _dummy = [
    {
      'judul': 'Kursus Photoshop',
      'durasi': '2 j 20 m',
      'rating': 4.8,
      'kategori': 'Desain',
      // Hapus 'ikon' karena sudah otomatis dari extension
    },
    {
      'judul': 'Desain 3D',
      'durasi': '3 j 15 m',
      'rating': 4.7,
      'kategori': 'Desain',
    },
    {
      'judul': 'Kursus JavaScript',
      'durasi': '2 j 50 m',
      'rating': 4.9,
      'kategori': 'Pemrograman',
    },
    {
      'judul': 'Internet of Things',
      'durasi': '1 j 40 m',
      'rating': 4.5,
      'kategori': 'Pemrograman',
    },
    {
      'judul': 'Machine Learning',
      'durasi': '3 j 20 m',
      'rating': 4.6,
      'kategori': 'Pemrograman',
    },
    {
      'judul': 'User Experience',
      'durasi': '2 j 45 m',
      'rating': 4.7,
      'kategori': 'Desain',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CourseBaseScreen(
      semuaKursus: _dummy,
      pageTitle: 'Kursus Siswa', // Menambahkan title yang spesifik
      activeTabIndex: 1, // Tab "Kursus" aktif
      onCourseTap: (course) {
        // TODO: navigasi ke detail kursus
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Buka detail "${course['judul']}"'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      onBottomTabSelect: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home-student');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/blogs');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
          // Index 1 (Kursus) tidak perlu action karena sudah di halaman ini
        }
      },
    );
  }
}
