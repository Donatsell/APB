import 'package:flutter/material.dart';
import '../../helpers/icon_helpers.dart';
import '../../models/course_model.dart';
import 'home_base_screen.dart';

class HomeMentorScreen extends StatefulWidget {
  const HomeMentorScreen({super.key});

  @override
  State<HomeMentorScreen> createState() => _HomeMentorScreenState();
}

class _HomeMentorScreenState extends State<HomeMentorScreen> {
  String selectedChip = 'Semua';

  final List<CourseModel> _allCourses = const [
    CourseModel(
      title: 'Programming Foundation',
      subtitle: 'Dasar-dasar coding modern',
      rating: 4.7,
      duration: '09:00 - 10:30',
      icon: Icons.computer, // Use IconData directly
    ),
    CourseModel(
      title: 'UI/UX Design Foundation',
      subtitle: 'Desain antarmuka & pengalaman pengguna',
      rating: 4.9,
      duration: '11:00 - 12:30',
      icon: Icons.design_services, // Use IconData directly
    ),
  ];

  List<Map<String, dynamic>> get _coursesAsMap {
    return _allCourses
        .map(
          (course) => {
            'title': course.title,
            'subtitle': course.subtitle,
            'rating': course.rating,
            'duration': course.duration,
            'icon': course.icon, // This is now a constant IconData
          },
        )
        .toList();
  }

  void _onCourseTap(Map<String, dynamic> courseData) {
    // Find the original CourseModel object
    final course = _allCourses.firstWhere(
      (c) => c.title == courseData['title'],
    );
    Navigator.pushNamed(context, '/course-detail', arguments: course);
  }

  void _onChipSelected(String chip) {
    setState(() {
      selectedChip = chip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeBaseScreen(
      greeting: 'Hai, Mentor! 👋',
      subtitle: 'Jadwal Kursus',
      courses: _coursesAsMap,
      onProfileTap: () => Navigator.pushNamed(context, '/profile'),
      onCourseTap: _onCourseTap,
      selectedTab: 0,
      onCourseTabTap: () => Navigator.pushNamed(context, '/choose-course'),
      onBlogTabTap: () => Navigator.pushNamed(context, '/blogs'),
      promoCard: _buildPromoCard(context),
      chipLabels: const ['Semua', 'UI/UX', 'Pemrograman', 'Desain'],
      selectedChip: selectedChip,
      onChipSelected: _onChipSelected,
      enableSearch: true,
      searchHint: 'Search...',
      bottomNavItems: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kursus Saya'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }

  Widget _buildPromoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFEF233C), Color(0xFF5E2E91)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Jadwal Kursus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Lihat jadwal mengajar',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap:
                      () => Navigator.pushNamed(context, '/teaching-schedule'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'View now',
                      style: TextStyle(
                        color: Color(0xFFEF233C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.laptop_chromebook,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
