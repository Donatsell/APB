import 'package:flutter/material.dart';
import 'course_base_screen.dart';

/// Halaman “Choose Course” khusus Student.
class CourseStudentScreen extends StatelessWidget {
  const CourseStudentScreen({super.key});

  static const _dummy = [
    {
      'title': 'Photoshop Course',
      'icon': Icons.photo,
      'duration': '2h 20m',
      'rating': 4.8,
      'category': 'Design',
    },
    {
      'title': '3D Design',
      'icon': Icons.view_in_ar,
      'duration': '3h 15m',
      'rating': 4.7,
      'category': 'Design',
    },
    {
      'title': 'JavaScript Course',
      'icon': Icons.code,
      'duration': '2h 50m',
      'rating': 4.9,
      'category': 'Programming',
    },
    {
      'title': 'Internet of Things',
      'icon': Icons.router,
      'duration': '1h 40m',
      'rating': 4.5,
      'category': 'Programming',
    },
    {
      'title': 'Machine Learning',
      'icon': Icons.memory,
      'duration': '3h 20m',
      'rating': 4.6,
      'category': 'Programming',
    },
    {
      'title': 'User Experience',
      'icon': Icons.person_outline,
      'duration': '2h 45m',
      'rating': 4.7,
      'category': 'Design',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CourseBaseScreen(
      allCourses: _dummy,
      onCourseTap: (c) {
        // TODO : buka detail course
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
