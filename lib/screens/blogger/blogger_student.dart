import 'package:flutter/material.dart';
import '../../helpers/navigation_helpers.dart';
import 'blogger_base_screen.dart';

class BloggerStudentScreen extends StatefulWidget {
  const BloggerStudentScreen({super.key});

  @override
  State<BloggerStudentScreen> createState() => _BloggerStudentScreenState();
}

class _BloggerStudentScreenState extends State<BloggerStudentScreen> {
  String _filter = 'Semua';
  final Set<int> _bookmarked = {};

  static const _dummy = [
    {
      'title': '5 Tips UI untuk Pemula',
      'snippet': 'Pelajari cara cepat memperbaiki antarmuka Anda.',
      'category': 'Desain',
      'date': '12 Apr 2025',
      'imageAsset': 'assets/images/UI-Dan-UX.jpg',
    },
    {
      'title': 'Memahami Async di Dart',
      'snippet': 'Future, Stream, async-await dengan bahasa sederhana.',
      'category': 'Pemrograman',
      'date': '09 Apr 2025',
      'imageAsset': 'assets/images/Sync-And-AsyncProgramming.jpg',
    },
    {
      'title': 'Dasar UX pada Formulir',
      'category': 'Desain',
      'date': '03 Apr 2025',
      'imageAsset': 'assets/images/Portofolio.jpg',
    },
    {
      'title': 'Bangun CRUD Backend Sendiri',
      'snippet': 'Node + Mongo langkah demi langkah.',
      'category': 'Pemrograman',
      'date': '28 Mar 2025',
      'imageAsset': 'assets/images/LearningAI.png',
    },
  ];

  List<Map<String, dynamic>> get _filtered =>
      _filter == 'Semua'
          ? _dummy
          : _dummy
              .where(
                (a) =>
                    a['category'].toString().toLowerCase() ==
                    _filter.toLowerCase(),
              )
              .toList();

  // bottom-nav handler - DIPERBAIKI
  void _handleBottom(int index) {
    switch (index) {
      case 0: // Home
        navigateToStudentHome(context);
        break;
      case 1: // Kursus
        navigateToCourseSelection(context);
        break;
      case 2: // Blog
        // Tidak perlu navigasi karena sudah di halaman blog
        // Atau bisa pakai navigateToBlogScreen jika perlu refresh
        break;
      case 3: // Profil
        navigateToProfileScreen(context);
        break;
    }
  }

  void _toggleBookmark(int idx) {
    setState(
      () =>
          _bookmarked.contains(idx)
              ? _bookmarked.remove(idx)
              : _bookmarked.add(idx),
    );
  }

  void _handleArticleTap(Map<String, dynamic> article) {
    // Gunakan fungsi navigasi untuk detail blog
    openBlogDetailScreen(context, article);

    // Atau tampilkan snackbar jika detail belum ada
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Buka "${article['title']}"')),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BloggerBaseScreen(
      appBarTitle: 'Artikel Terbaru',
      filters: const ['Semua', 'Pemrograman', 'Desain'],
      selectedFilter: _filter,
      onFilterChange: (f) => setState(() => _filter = f),
      articles: _filtered,
      bookmarked: _bookmarked,
      onBookmarkToggle: _toggleBookmark,
      onArticleTap: _handleArticleTap, // Menggunakan fungsi terpisah
      currentTab: 2,
      onBottomSelect: _handleBottom,
    );
  }
}
