import 'package:flutter/material.dart';

typedef CourseTap = void Function(Map<String, dynamic> course);
typedef BottomTabSelect = void Function(int index);

class CourseBaseScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allCourses;
  final CourseTap onCourseTap;

  /// callback jika user men-tap item bottom-nav:
  /// 0 = Home, 1 = MyCourse, 2 = Blogs, 3 = Profile
  final BottomTabSelect? onBottomTabSelect;

  const CourseBaseScreen({
    super.key,
    required this.allCourses,
    required this.onCourseTap,
    this.onBottomTabSelect,
  });

  @override
  State<CourseBaseScreen> createState() => _CourseBaseScreenState();
}

class _CourseBaseScreenState extends State<CourseBaseScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered =
        _selectedFilter == 'All'
            ? widget.allCourses
            : widget.allCourses
                .where((c) => c['category'] == _selectedFilter)
                .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Choose Course'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: _bottomBar(),
      body: Column(
        children: [
          _filterChips(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _courseCard(filtered[i]),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- bottom nav ----------

  BottomNavigationBar _bottomBar() => BottomNavigationBar(
    currentIndex: 1, // “My Course” selected
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.grey,
    onTap: (i) => widget.onBottomTabSelect?.call(i),
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Course'),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blogs'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  );

  // ---------- filter & list ----------

  Widget _filterChips() {
    const filters = ['All', 'Design', 'Programming'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children:
            filters.map((f) {
              final sel = f == _selectedFilter;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ChoiceChip(
                  label: Text(f),
                  selected: sel,
                  selectedColor: Colors.deepPurple,
                  labelStyle: TextStyle(
                    color: sel ? Colors.white : Colors.black,
                  ),
                  onSelected: (_) => setState(() => _selectedFilter = f),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _courseCard(Map<String, dynamic> c) => GestureDetector(
    onTap: () => widget.onCourseTap(c),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(c['icon'] as IconData, size: 40, color: Colors.deepPurple),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      c['duration'],
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.star, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      '${c['rating']}',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
