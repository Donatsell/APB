import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

/// Home screen for guest (belum login). Semua ikon yang dapat ditekan
///—baik di header, BottomNavigationBar, maupun di daftar course—akan
///mengarah ke `LoginScreen`. Teks tanpa ikon tetap tidak aktif.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        // Semua tab ikon redirect ke LoginScreen
        onTap: (_) => _goToLogin(context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blogs'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              const Text(
                'Hello, Coqu Guest',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('What do you want to learn?'),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildNewCourseCard(context),
              const SizedBox(height: 20),
              _buildCourseSectionTitle(),
              const SizedBox(height: 10),
              _buildCategoryChips(),
              const SizedBox(height: 20),
              Expanded(child: _buildCourseList(context)),
            ],
          ),
        ),
      ),
    );
  }

  // ────────────────────────── NAVIGATION HELPER ────────────────────────── //

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  // ────────────────────────── SECTION WIDGETS ────────────────────────── //

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => _goToLogin(context),
          child: const Icon(Icons.grid_view, color: Colors.purple),
        ),
        GestureDetector(
          onTap: () => _goToLogin(context),
          child: const CircleAvatar(
            backgroundColor: Colors.purple,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
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
  }

  /// Gradient card with curved white accent & illustration
  Widget _buildNewCourseCard(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4C1D95), Color(0xFF9333EA)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),

            // Curved accent line
            Positioned.fill(child: CustomPaint(painter: _ArcPainter())),

            // Illustration on the right (klik -> login)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => _goToLogin(context),
                child: Image.asset(
                  'assets/images/WorkingFrames.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Text & CTA button (CTA tidak dialihkan)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'New Course!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'User Experience Class',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseSectionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Course',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        TextButton(onPressed: () {}, child: const Text('View All')),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 8,
      children: [
        _buildChip('All', isSelected: true),
        _buildChip('Design'),
        _buildChip('Programming'),
        _buildChip('UI/UX'),
      ],
    );
  }

  Widget _buildChip(String label, {bool isSelected = false}) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? Colors.purple : Colors.grey[200],
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }

  Widget _buildCourseList(BuildContext context) {
    final courses = [
      {
        'title': 'Photoshop Course',
        'rating': 5.0,
        'duration': '5h 15m',
        'icon': Icons.image,
      },
      {
        'title': '3D Design',
        'rating': 4.6,
        'duration': '10h 30m',
        'icon': Icons.view_in_ar,
      },
    ];

    return ListView.separated(
      itemCount: courses.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final course = courses[index];
        return _buildCourseCard(
          context,
          title: course['title'] as String,
          rating: course['rating'] as double,
          duration: course['duration'] as String,
          icon: course['icon'] as IconData,
        );
      },
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required String title,
    required double rating,
    required String duration,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _goToLogin(context),
            child: Icon(icon, size: 40, color: Colors.purple),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                      '$rating  •  $duration',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────── PAINTERS ────────────────────────── //

class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.85)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final path =
        Path()
          ..moveTo(0, size.height * 0.1)
          ..quadraticBezierTo(
            size.width * 0.35,
            size.height * 0.6,
            size.width,
            size.height * 0.2,
          );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
