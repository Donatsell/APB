import 'package:flutter/material.dart';

class BlogsPage extends StatefulWidget {
  @override
  _BlogsPageState createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  String selectedCategory = 'All';

  final List<Map<String, String>> articles = [
    {
      'title': '5 UI Tips for Beginners',
      'category': 'UI/UX Tips',
      'date': 'April 19, 2025',
      'tag': 'UI/UX',
    },
    {
      'title': 'Understanding Async & Sync Programing',
      'category': 'Programming',
      'date': 'April 12, 2025',
      'tag': 'Programming',
    },
    {
      'title': 'How To Make a Portfolio',
      'category': 'Design',
      'date': 'April 5, 2025',
      'tag': 'Design',
    },
    {
      'title': 'Build Your Career in AI',
      'category': 'Career Tips',
      'date': 'April 10, 2025',
      'tag': 'Career Tips',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredArticles =
        selectedCategory == 'All'
            ? articles
            : articles.where((a) => a['tag'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Latest Articles",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      [
                        'All',
                        'Programming',
                        'UI/UX Tips',
                        'Design',
                        'Career Tips',
                        'AI Tips',
                      ].map((category) {
                        final isSelected = selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(category),
                            selected: isSelected,
                            selectedColor: Colors.red,
                            backgroundColor: Colors.grey.shade200,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            onSelected: (_) {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                          ),
                        );
                      }).toList(),
                ),
              ),
              SizedBox(height: 16),

              // List of articles
              Expanded(
                child: ListView.builder(
                  itemCount: filteredArticles.length,
                  itemBuilder: (context, index) {
                    final article = filteredArticles[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // Image placeholder
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.article_outlined,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),

                          // Article Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article['title']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${article['tag']} · ${article['date']}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Bookmark icon
                          Icon(Icons.bookmark_border),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
