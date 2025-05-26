import 'package:flutter/material.dart';
import 'home_base_screen.dart';

class HomeMentorScreen extends StatelessWidget {
  const HomeMentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeBaseScreen(
      greeting: 'Welcome, Mentor 💼',
      courses: const [
        {
          'title': 'Manage Your Course',
          'rating': 4.7,
          'duration': '3h',
          'icon': Icons.manage_accounts,
        },
        {
          'title': 'Mentoring Essentials',
          'rating': 4.9,
          'duration': '4h',
          'icon': Icons.support_agent,
        },
      ],
      onProfileTap: () => Navigator.pushNamed(context, '/mentor-profile'),
      onCourseTap:
          (c) => Navigator.pushNamed(
            context,
            '/mentor-course-detail',
            arguments: c,
          ),
    );
  }
}
