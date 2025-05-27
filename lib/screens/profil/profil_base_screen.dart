import 'package:flutter/material.dart';

typedef OnMenuTap = void Function(String id);
typedef OnTabSelect = void Function(int index);

class ProfileBaseScreen extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String email;

  final int coursesCompleted; // 6
  final int totalCourses; // 15 – supaya “6/15”
  final String totalTime; // “9j 35m”
  final String streak; // “3 hari”

  final OnMenuTap onMenuTap;
  final int currentTab;
  final OnTabSelect onTabSelect;

  const ProfileBaseScreen({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.email,
    required this.coursesCompleted,
    required this.totalCourses,
    required this.totalTime,
    required this.streak,
    required this.onMenuTap,
    required this.currentTab,
    required this.onTabSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ------------ APP-BAR ------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(), // supaya ikon back di kanan
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      // ------------ BODY ------------
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // ----- AVATAR & NAME -----
            CircleAvatar(radius: 60, backgroundImage: NetworkImage(avatarUrl)),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),

            // ----- STATS -----
            _statRow(
              Icons.menu_book_rounded,
              'Kursus Selesai',
              '$coursesCompleted/$totalCourses',
            ),
            const SizedBox(height: 20),
            _statRow(
              Icons.access_time_filled_rounded,
              'Total Waktu Belajar',
              totalTime,
            ),
            const SizedBox(height: 20),
            _statRow(Icons.local_fire_department_rounded, 'Streak', streak),
            const SizedBox(height: 32),

            // ----- MENU LIST -----
            _menuButton(Icons.play_circle_fill, 'Kursus Saya'),
            _menuButton(Icons.bookmark, 'Blog yang Disimpan'),
            _menuButton(Icons.history, 'Riwayat Belajar'),
            _menuButton(Icons.language, 'Bahasa'),
          ],
        ),
      ),
      // ------------ BOTTOM NAV ------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: onTabSelect,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kursus Saya'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil Saya',
          ),
        ],
      ),
    );
  }

  // ───────────────── helpers ─────────────────
  Widget _statRow(IconData icon, String label, String value) => Row(
    children: [
      Icon(icon, color: Colors.black, size: 28),
      const SizedBox(width: 12),
      Expanded(child: Text(label)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    ],
  );

  Widget _menuButton(IconData icon, String label) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        side: const BorderSide(color: Colors.deepPurple),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => onMenuTap(label),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 16),
          Expanded(child: Text(label)),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.deepPurple,
          ),
        ],
      ),
    ),
  );
}
