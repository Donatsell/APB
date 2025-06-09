import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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
              _Header(onTap: () => _goToLogin(context)),
              const SizedBox(height: 20),
              const Text(
                'Hello, Coqu Guest',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text('What do you want to learn?'),
              const SizedBox(height: 20),
              const _SearchBar(),
              const SizedBox(height: 20),
              _NewCourseCard(onTap: () => _goToLogin(context)),
              const SizedBox(height: 20),
              _CourseSectionTitle(),
              const SizedBox(height: 10),
              const _CategoryChips(),
              const SizedBox(height: 20),
              Expanded(child: _CourseList(onTap: () => _goToLogin(context))),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────── WIDGETS ────────────────────────── //

class _Header extends StatelessWidget {
  final VoidCallback onTap;
  const _Header({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Icon(Icons.grid_view, color: Colors.purple),
        ),
        GestureDetector(
          onTap: onTap,
          child: const CircleAvatar(
            backgroundColor: Colors.purple,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
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
}

class _NewCourseCard extends StatelessWidget {
  final VoidCallback onTap;

  const _NewCourseCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4C1D95), Color(0xFF9333EA)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
            Positioned.fill(child: CustomPaint(painter: _ArcPainter())),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/WorkingFrames.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
}

class _CourseSectionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips();

  @override
  Widget build(BuildContext context) {
    const categories = ['All', 'Design', 'Programming', 'UI/UX'];
    return Wrap(
      spacing: 8,
      children:
          categories
              .asMap()
              .entries
              .map(
                (entry) => Chip(
                  label: Text(entry.value),
                  backgroundColor:
                      entry.key == 0 ? Colors.purple : Colors.grey[200],
                  labelStyle: TextStyle(
                    color: entry.key == 0 ? Colors.white : Colors.black87,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                ),
              )
              .toList(),
    );
  }
}

class _CourseList extends StatelessWidget {
  final VoidCallback onTap;
  const _CourseList({required this.onTap});

  @override
  Widget build(BuildContext context) {
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
        return _CourseCard(
          title: course['title'] as String,
          rating: course['rating'] as double,
          duration: course['duration'] as String,
          icon: course['icon'] as IconData,
          onTap: onTap,
        );
      },
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String title;
  final double rating;
  final String duration;
  final IconData icon;
  final VoidCallback onTap;

  const _CourseCard({
    required this.title,
    required this.rating,
    required this.duration,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
            onTap: onTap,
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
