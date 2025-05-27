import 'package:flutter/material.dart';
import 'course_base_screen.dart';

/// Halaman *Pilih Kursus* (khusus Siswa)
class CourseStudentScreen extends StatelessWidget {
  const CourseStudentScreen({super.key});

  /// Data contoh (bisa diganti API / Firestore)
  static const _dummy = [
    {
      'judul': 'Kursus Photoshop',
      'ikon': Icons.photo,
      'durasi': '2 j 20 m',
      'rating': 4.8,
      'kategori': 'Desain',
    },
    {
      'judul': 'Desain 3D',
      'ikon': Icons.view_in_ar,
      'durasi': '3 j 15 m',
      'rating': 4.7,
      'kategori': 'Desain',
    },
    {
      'judul': 'Kursus JavaScript',
      'ikon': Icons.code,
      'durasi': '2 j 50 m',
      'rating': 4.9,
      'kategori': 'Pemrograman',
    },
    {
      'judul': 'Internet of Things',
      'ikon': Icons.router,
      'durasi': '1 j 40 m',
      'rating': 4.5,
      'kategori': 'Pemrograman',
    },
    {
      'judul': 'Machine Learning',
      'ikon': Icons.memory,
      'durasi': '3 j 20 m',
      'rating': 4.6,
      'kategori': 'Pemrograman',
    },
    {
      'judul': 'User Experience',
      'ikon': Icons.person_outline,
      'durasi': '2 j 45 m',
      'rating': 4.7,
      'kategori': 'Desain',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CourseBaseScreen(
      semuaKursus: _dummy,
      onCourseTap: (c) {
        // TODO: navigasi ke detail kursus
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Buka detail "${c['judul']}"')));
      },
      onBottomTabSelect: (i) {
        switch (i) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home-student');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/blogs');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
