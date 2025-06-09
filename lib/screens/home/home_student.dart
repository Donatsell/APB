import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_base_screen.dart';

class HomeStudentScreen extends StatefulWidget {
  const HomeStudentScreen({super.key});

  @override
  State<HomeStudentScreen> createState() => _HomeStudentScreenState();
}

class _HomeStudentScreenState extends State<HomeStudentScreen> {
  String selectedChip = 'Recommended';

  static const _allCourses = [
    {
      'title': 'Flutter for Beginners',
      'subtitle': 'Learn mobile app development with Flutter',
      'rating': 4.8,
      'duration': '8h',
      'icon': Icons.mobile_friendly,
      'category': 'Programming',
    },
    {
      'title': 'UI/UX Fundamentals',
      'subtitle': 'Master the basics of user interface design',
      'rating': 4.7,
      'duration': '6h 30m',
      'icon': Icons.design_services,
      'category': 'Design',
    },
    {
      'title': 'JavaScript Mastery',
      'subtitle': 'Complete guide to modern JavaScript',
      'rating': 4.9,
      'duration': '12h',
      'icon': Icons.code,
      'category': 'Programming',
    },
    {
      'title': 'Advanced UI/UX Design',
      'subtitle': 'Professional design techniques and workflows',
      'rating': 4.6,
      'duration': '10h',
      'icon': Icons.palette,
      'category': 'UI/UX',
    },
    {
      'title': 'React Native Development',
      'subtitle': 'Build cross-platform mobile apps',
      'rating': 4.5,
      'duration': '15h',
      'icon': Icons.smartphone,
      'category': 'Programming',
    },
    {
      'title': 'Figma Masterclass',
      'subtitle': 'Complete design tool mastery',
      'rating': 4.8,
      'duration': '7h',
      'icon': Icons.brush,
      'category': 'Design',
    },
  ];

  List<Map<String, dynamic>> get _filteredCourses {
    if (selectedChip == 'Recommended') {
      // Return top rated courses for recommended
      return _allCourses.where((course) {
        final rating = course['rating'];
        return rating is num && rating >= 4.7;
      }).toList();
    }
    return _allCourses
        .where((course) => course['category'] == selectedChip)
        .toList();
  }

  void _onChipSelected(String chip) {
    setState(() {
      selectedChip = chip;
    });
  }

  void _toMyCourse() => Navigator.pushNamed(context, '/choose-course');

  void _toBlogs() => Navigator.pushNamed(context, '/blogs');

  void _toProfile() => Navigator.pushNamed(context, '/profile');

  void _toCourseDetail(Map<String, dynamic> course) =>
      Navigator.pushNamed(context, '/course-detail', arguments: course);

  @override
  Widget build(BuildContext context) {
    final nama = FirebaseAuth.instance.currentUser?.displayName ?? 'Student';

    return HomeBaseScreen(
      greeting: 'Hi, $nama 👋',
      subtitle: 'What do you want to learn today?',
      courses: _filteredCourses,
      onProfileTap: _toProfile,
      onCourseTap: _toCourseDetail,
      onCourseTabTap: _toMyCourse,
      onBlogTabTap: _toBlogs,
      selectedTab: 0,
      selectedChip: selectedChip,
      onChipSelected: _onChipSelected,
      chipLabels: const ['Recommended', 'Design', 'Programming', 'UI/UX'],
      promoCard: _buildPromoCard(),
      enableSearch: true,
      searchHint: 'Search courses...',
      bottomNavItems: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Course'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blogs'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  Widget _buildPromoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF9333EA), Color(0xFF6D28D9)],
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
                  'Project-Based Learning 💡',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Learn by building real projects',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/project-courses'),
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
                      'Enroll now',
                      style: TextStyle(
                        color: Color(0xFF9333EA),
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
            child: const Icon(Icons.school, color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }
}
