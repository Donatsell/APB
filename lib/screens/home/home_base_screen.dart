import 'package:flutter/material.dart';

typedef CourseTap = void Function(Map<String, dynamic> course);

/// Kerangka dasar Home (Siswa / Mentor / Tamu)
class HomeBaseScreen extends StatelessWidget {
  // ── properti utama ────────────────────────────────────────────────
  final String greeting;
  final VoidCallback onProfileTap;

  // bottom-nav
  final int selectedTab;
  final VoidCallback? onCourseTabTap;
  final VoidCallback? onBlogTabTap;

  // daftar kursus
  final List<Map<String, dynamic>> courses;
  final CourseTap onCourseTap;

  // opsional
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

  // ── BUILD ────────────────────────────────────────────────────────
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
              const Text('Apa yang ingin kamu pelajari hari ini?'),
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

  // ── WIDGET RINGAN ────────────────────────────────────────────────
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
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kursus Saya'),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
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

  Widget _searchBar() => const TextField(
    decoration: InputDecoration(
      hintText: 'Cari...',
      prefixIcon: Icon(Icons.search),
      filled: true,
      fillColor: Color(0xFFF3F4F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
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
    itemBuilder: (_, i) {
      final c = courses[i];
      return GestureDetector(
        onTap: () => onCourseTap(c),
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
              Icon(c['icon'] as IconData, size: 40, color: Colors.purple),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
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
                          '${c['rating']} • ${c['duration']}',
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
      );
    },
  );
}
