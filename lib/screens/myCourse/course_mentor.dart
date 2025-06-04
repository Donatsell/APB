import 'package:flutter/material.dart';

class CoursesMentorScreen extends StatefulWidget {
  final Function(int)? onBottomTabSelect;

  const CoursesMentorScreen({super.key, this.onBottomTabSelect});

  @override
  State<CoursesMentorScreen> createState() => _CoursesMentorScreenState();
}

class _CoursesMentorScreenState extends State<CoursesMentorScreen> {
  String _selectedCategory = 'Semua';

  final List<Map<String, dynamic>> courses = [
    {
      'judul': 'Programming Foundations',
      'kategori': 'Pemrograman',
      'warna': Colors.deepPurple,
      'ikon': Icons.code,
      'durasi': '12 minggu',
      'rating': 4.8,
    },
    {
      'judul': 'UI/UX Design Foundations',
      'kategori': 'Desain',
      'warna': Colors.blue,
      'ikon': Icons.design_services,
      'durasi': '8 minggu',
      'rating': 4.7,
    },
    {
      'judul': 'Design Portfolio Foundations',
      'kategori': 'Desain',
      'warna': Colors.green,
      'ikon': Icons.folder,
      'durasi': '6 minggu',
      'rating': 4.6,
    },
    {
      'judul': 'Internet of Things Foundations',
      'kategori': 'Pemrograman',
      'warna': Colors.orange,
      'ikon': Icons.devices,
      'durasi': '10 minggu',
      'rating': 4.5,
    },
    {
      'judul': 'Machine Learning Foundations',
      'kategori': 'Pemrograman',
      'warna': Colors.red,
      'ikon': Icons.psychology,
      'durasi': '16 minggu',
      'rating': 4.9,
    },
    {
      'judul': 'Photoshop Foundations',
      'kategori': 'Desain',
      'warna': Colors.purple,
      'ikon': Icons.photo,
      'durasi': '4 minggu',
      'rating': 4.4,
    },
  ];

  List<Map<String, dynamic>> get _filteredCourses {
    if (_selectedCategory == 'Semua') return courses;
    return courses
        .where(
          (c) =>
              (c['kategori'] ?? '').toString().toLowerCase() ==
              _selectedCategory.toLowerCase(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kelola Kursus'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Handle settings
            },
          ),
        ],
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1, // Course tab selected
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 8,
      onTap: (index) => widget.onBottomTabSelect?.call(index),
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

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showManageOptions(course),
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
                  color: course['warna'] as Color? ?? Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  course['ikon'] as IconData? ?? Icons.book,
                  color: Colors.white,
                  size: 24,
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

              // Manage Button
              TextButton(
                onPressed: () => _showManageOptions(course),
                child: const Text(
                  'Kelola',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showManageOptions(Map<String, dynamic> course) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Kelola ${course['judul']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Edit Kursus'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle edit
                },
              ),
              ListTile(
                leading: const Icon(Icons.people, color: Colors.green),
                title: const Text('Lihat Siswa'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle view students
                },
              ),
              ListTile(
                leading: const Icon(Icons.analytics, color: Colors.orange),
                title: const Text('Lihat Analitik'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle analytics
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Hapus Kursus'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(course);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Kursus'),
          content: Text(
            'Apakah Anda yakin ingin menghapus "${course['judul']}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  courses.remove(course);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${course['judul']} dihapus'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
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
