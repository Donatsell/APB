import 'package:flutter/material.dart';

typedef OnMenuTap = void Function(String id);
typedef OnTabSelect = void Function(int index);

class ProfileBaseScreen extends StatelessWidget {
  const ProfileBaseScreen({
    super.key,
    // data utama
    required this.avatarUrl,
    required this.name,
    required this.email,
    required this.coursesCompleted,
    required this.totalCourses,
    required this.totalTime,
    required this.streak,
    // callback
    required this.onMenuTap,
    required this.currentTab,
    required this.onTabSelect,
  });

  // ────── field ──────
  final String avatarUrl;
  final String name;
  final String email;
  final int coursesCompleted;
  final int totalCourses;
  final String totalTime;
  final String streak;

  final OnMenuTap onMenuTap;
  final int currentTab;
  final OnTabSelect onTabSelect;

  // ────── UI ──────
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,

    // ---------- APP-BAR ----------
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const SizedBox(), // tombol “back” dipindah ke kanan
      actions: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),

    // ---------- BODY ----------
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // ▸▸ AVATAR – tap ⇒ 'Ganti Foto'
          GestureDetector(
            onTap: () => onMenuTap('Ganti Foto'),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage(avatarUrl),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(email, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),

          // ▸▸ STATISTIK
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
          _statRow(Icons.local_fire_department, 'Streak', streak),
          const SizedBox(height: 32),

          // ▸▸ LIST MENU
          _menuButton(Icons.play_circle_fill, 'Kursus Saya'),
          _menuButton(Icons.bookmark, 'Blog yang Disimpan'),
          _menuButton(Icons.history, 'Riwayat Belajar'),
          _menuButton(Icons.language, 'Bahasa'),
        ],
      ),
    ),

    // ---------- BOTTOM-NAV ----------
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: currentTab,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: onTabSelect,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kursus'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    ),
  );

  // ── komponen kecil ──
  Widget _statRow(IconData ic, String label, String value) => Row(
    children: [
      Icon(ic, size: 28),
      const SizedBox(width: 12),
      Expanded(child: Text(label)),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    ],
  );

  Widget _menuButton(IconData ic, String label) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: OutlinedButton(
      onPressed: () => onMenuTap(label),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.deepPurple),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
      child: Row(
        children: [
          Icon(ic, color: Colors.deepPurple),
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
