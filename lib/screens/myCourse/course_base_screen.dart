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

  const CourseBaseScreen({
    super.key,
    required this.semuaKursus,
    required this.onCourseTap,
    this.onBottomTabSelect,
  });

  @override
  State<CourseBaseScreen> createState() => _CourseBaseScreenState();
}

class _CourseBaseScreenState extends State<CourseBaseScreen> {
  String _filter = 'Semua';

  /// Helper — menghasilkan daftar yang sudah difilter
  List<Map<String, dynamic>> get _tampil {
    if (_filter == 'Semua') return widget.semuaKursus;
    return widget.semuaKursus
        .where(
          (c) =>
              (c['kategori'] ?? '').toString().toLowerCase() ==
              _filter.toLowerCase(),
        )
        .toList();
  }

  // ─────────────────────────── BUILD ───────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pilih Kursus'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: _bottomBar(),
      body: Column(
        children: [
          _chipFilter(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _tampil.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _kartuKursus(_tampil[i]),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── BOTTOM NAV ─────────────────────────
  BottomNavigationBar _bottomBar() => BottomNavigationBar(
    currentIndex: 1, // tab “Kursus Saya”
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.grey,
    onTap: (i) => widget.onBottomTabSelect?.call(i),
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kursus'),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
    ],
  );

  // ───────────────────────── CHIP FILTER ─────────────────────────
  Widget _chipFilter() {
    const filters = ['Semua', 'Desain', 'Pemrograman'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children:
            filters
                .map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ChoiceChip(
                      label: Text(f),
                      selected: f == _filter,
                      selectedColor: Colors.deepPurple,
                      labelStyle: TextStyle(
                        color: f == _filter ? Colors.white : Colors.black,
                      ),
                      onSelected: (_) => setState(() => _filter = f),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  // ───────────────────────── KARTU KURSUS ─────────────────────────
  Widget _kartuKursus(Map<String, dynamic> c) => GestureDetector(
    onTap: () => widget.onCourseTap(c),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            c['ikon'] as IconData? ?? Icons.book,
            size: 40,
            color: Colors.deepPurple,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c['judul'] ?? 'Tanpa Judul',
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
                      c['durasi'] ?? '-',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.star, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      '${c['rating'] ?? '-'}',
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
