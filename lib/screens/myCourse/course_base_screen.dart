import 'package:flutter/material.dart';

/// Tipe callback-callback
typedef CourseTap = void Function(Map<String, dynamic> course);
typedef BottomTabSelect = void Function(int index);

/// Kerangka umum halaman **Pilih Kursus** (dipakai Siswa/Mentor).
class CourseBaseScreen extends StatefulWidget {
  /// Semua data kursus yang akan ditampilkan
  final List<Map<String, dynamic>> semuaKursus;

  /// Dipanggil ketika kartu kursus diklik
  final CourseTap onCourseTap;

  /// Dipanggil ketika bottom-nav ditekan (opsional)
  final BottomTabSelect? onBottomTabSelect;

  /// Judul halaman (default: 'Pilih Kursus')
  final String? pageTitle;

  /// Index tab yang aktif di bottom navigation (default: 1)
  final int activeTabIndex;

  const CourseBaseScreen({
    super.key,
    required this.semuaKursus,
    required this.onCourseTap,
    this.onBottomTabSelect,
    this.pageTitle,
    this.activeTabIndex = 1,
  });

  @override
  State<CourseBaseScreen> createState() => _CourseBaseScreenState();
}

class _CourseBaseScreenState extends State<CourseBaseScreen> {
  String _selectedCategory = 'Semua';

  /// Helper — menghasilkan daftar yang sudah difilter
  List<Map<String, dynamic>> get _filteredCourses {
    if (_selectedCategory == 'Semua') return widget.semuaKursus;
    return widget.semuaKursus
        .where(
          (c) =>
              (c['kategori'] ?? '').toString().toLowerCase() ==
              _selectedCategory.toLowerCase(),
        )
        .toList();
  }

  // ─────────────────────────── BUILD ───────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.pageTitle ?? 'Pilih Kursus'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryFilter(),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _filteredCourses.isEmpty
                      ? _buildEmptyState()
                      : _buildCourseList(),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────── BOTTOM NAV ─────────────────────────
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: widget.activeTabIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 8,
      onTap: (i) => widget.onBottomTabSelect?.call(i),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          activeIcon: Icon(Icons.book),
          label: 'Kursus',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          activeIcon: Icon(Icons.article),
          label: 'Blog',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }

  // ───────────────────────── CATEGORY FILTER ─────────────────────────
  Widget _buildCategoryFilter() {
    const categories = ['Semua', 'Desain', 'Pemrograman'];

    return Row(
      children:
          categories.map((category) {
            final isSelected = category == _selectedCategory;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ChoiceChip(
                label: Text(category),
                selected: isSelected,
                selectedColor: Colors.deepPurple,
                backgroundColor: Colors.grey.shade200,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                onSelected: (_) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
            );
          }).toList(),
    );
  }

  // ───────────────────────── COURSE LIST ─────────────────────────
  Widget _buildCourseList() {
    return ListView.separated(
      itemCount: _filteredCourses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final course = _filteredCourses[index];
        return _buildCourseCard(course);
      },
    );
  }

  // ───────────────────────── EMPTY STATE ─────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Tidak ada kursus tersedia',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba ubah filter atau cek lagi nanti',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── COURSE CARD ─────────────────────────
  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onCourseTap(course),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Row(
            children: [
              // Course Icon/Thumbnail
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: course['warna'] as Color? ?? course.categoryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  course['ikon'] as IconData? ?? course.categoryIcon,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),

              // Course Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['judul'] ?? 'Tanpa Judul',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Course Metadata
                    Row(
                      children: [
                        if (course['durasi'] != null) ...[
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            course['durasi'].toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],

                        if (course['durasi'] != null &&
                            course['rating'] != null)
                          const SizedBox(width: 12),

                        if (course['rating'] != null) ...[
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            course['rating'].toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    ),

                    // Course Category Badge
                    if (course['kategori'] != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          course['kategori'].toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────── EXTENSION HELPERS ───────────────────────
extension CourseDataExtension on Map<String, dynamic> {
  /// Helper untuk mendapatkan warna berdasarkan kategori
  Color get categoryColor {
    switch ((this['kategori'] ?? '').toString().toLowerCase()) {
      case 'desain':
        return Colors.blue;
      case 'pemrograman':
        return Colors.green;
      default:
        return Colors.deepPurple;
    }
  }

  /// Helper untuk mendapatkan ikon berdasarkan kategori
  IconData get categoryIcon {
    switch ((this['kategori'] ?? '').toString().toLowerCase()) {
      case 'desain':
        return Icons.design_services;
      case 'pemrograman':
        return Icons.code;
      default:
        return Icons.book;
    }
  }
}
