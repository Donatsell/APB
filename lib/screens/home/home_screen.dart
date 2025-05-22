import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // ✅ Tambahkan const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blogs',
          ),
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
              // 🔹 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.grid_view, color: Colors.purple),
                  const CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Hello, Coqu Student",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text("What do you want to learn?"),
              const SizedBox(height: 20),

              // 🔹 Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 New Course Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "New Course!",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "User Experience Class",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            child: const Text("View now"),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/images/ux.png',
                      height: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Course Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Course",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(onPressed: () {}, child: const Text("View All")),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildChip("All", isSelected: false),
                  const SizedBox(width: 8),
                  _buildChip("Design", isSelected: true),
                  const SizedBox(width: 8),
                  _buildChip("Programming", isSelected: false),
                  const SizedBox(width: 8),
                  _buildChip("UI/UX", isSelected: false),
                ],
              ),
              const SizedBox(height: 20),

              // 🔹 Course List
              Expanded(
                child: ListView(
                  children: [
                    _buildCourseCard(
                      title: "Photoshop Course",
                      rating: 5.0,
                      duration: "5h 15m",
                      icon: Icons.image,
                    ),
                    const SizedBox(height: 12),
                    _buildCourseCard(
                      title: "3D Design",
                      rating: 4.6,
                      duration: "10h 30m",
                      icon: Icons.view_in_ar,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, {bool isSelected = false}) {
    return Chip(
      label: Text(label),
      backgroundColor: isSelected ? Colors.purple : Colors.grey[200],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }

  Widget _buildCourseCard({
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
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.purple),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "$rating  •  $duration",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
