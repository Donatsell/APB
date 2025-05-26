import 'package:flutter/material.dart';

typedef CourseTap = void Function(Map<String, dynamic> course);

/// Kerangka bersama (Student/Mentor/Guest) –
/// berisi header, search-bar, chip, daftar course & bottom-nav
class HomeBaseScreen extends StatelessWidget {
  // header & greet
  final String greeting;
  final VoidCallback onProfileTap;

  // bottom-nav
  final int selectedTab; // 0=Home,1=MyCourse,2=Blogs,3=Profile
  final VoidCallback? onCourseTabTap;
  final VoidCallback? onBlogTabTap;

  // list course
  final List<Map<String, dynamic>> courses;
  final CourseTap onCourseTap;

  // optional promo / chips
  final Widget? promoCard;
  final List<String>? chipLabels;
  final String? selectedChip;

  const HomeBaseScreen({
    super.key,
    required this.greeting,
    required this.courses,
    required this.onProfileTap,
    required this.onCourseTap,
    this.selectedTab = 0,
    this.onCourseTabTap,
    this.onBlogTabTap,
    this.promoCard,
    this.chipLabels,
    this.selectedChip,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 20),
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text('What do you want to learn today?'),
              const SizedBox(height: 16),
              _searchBar(),
              if (promoCard != null) ...[
                const SizedBox(height: 16),
                promoCard!,
              ],
              if (chipLabels != null) ...[
                const SizedBox(height: 24),
                _chipRow(),
              ],
              const SizedBox(height: 16),
              Expanded(child: _courseList()),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- widgets ----------

  BottomNavigationBar _bottomBar() => BottomNavigationBar(
    currentIndex: selectedTab,
    selectedItemColor: Colors.purple,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    onTap: (i) {
      switch (i) {
        case 1:
          onCourseTabTap?.call();
          break;
        case 2:
          onBlogTabTap?.call();
          break;
        case 3:
          onProfileTap();
          break;
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Course'),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blogs'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  );

  Widget _header() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Icon(Icons.grid_view, color: Colors.purple),
      GestureDetector(
        onTap: onProfileTap,
        child: const CircleAvatar(
          backgroundColor: Colors.purple,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ),
    ],
  );

  Widget _searchBar() => TextField(
    decoration: InputDecoration(
      hintText: 'Search...',
      prefixIcon: const Icon(Icons.search),
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
  );

  Widget _chipRow() => Wrap(
    spacing: 8,
    children:
        chipLabels!
            .map(
              (label) => Chip(
                label: Text(label),
                backgroundColor:
                    label == selectedChip ? Colors.purple : Colors.grey[200],
                labelStyle: TextStyle(
                  color: label == selectedChip ? Colors.white : Colors.black87,
                ),
              ),
            )
            .toList(),
  );

  Widget _courseList() => ListView.separated(
    itemCount: courses.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder:
        (_, i) => GestureDetector(
          onTap: () => onCourseTap(courses[i]),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  courses[i]['icon'] as IconData,
                  size: 40,
                  color: Colors.purple,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courses[i]['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${courses[i]['rating']} • ${courses[i]['duration']}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
