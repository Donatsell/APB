import 'package:flutter/material.dart';

typedef ArticleTap = void Function(Map<String, dynamic> artikel);
typedef BookmarkToggle = void Function(int index);
typedef BottomTabSelect = void Function(int index);

/// Kerangka umum halaman **Blog / Artikel**
class BloggerBaseScreen extends StatelessWidget {
  // ――― properti
  final String appBarTitle;
  final List<String> filters;
  final String selectedFilter;
  final void Function(String) onFilterChange;

  final List<Map<String, dynamic>> articles;
  final ArticleTap onArticleTap;
  final BookmarkToggle onBookmarkToggle;
  final Set<int> bookmarked;

  final int currentTab;
  final BottomTabSelect onBottomSelect;

  const BloggerBaseScreen({
    super.key,
    required this.appBarTitle,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterChange,
    required this.articles,
    required this.onArticleTap,
    required this.onBookmarkToggle,
    required this.bookmarked,
    this.currentTab = 2,
    required this.onBottomSelect,
  });

  // ――― BUILD ―――
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(appBarTitle),
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: _bottomNav(),
      body: Column(
        children: [
          _filterRow(),
          const SizedBox(height: 12),
          Expanded(child: _articleList()),
        ],
      ),
    );
  }

  // ――― Bottom-nav ―――
  BottomNavigationBar _bottomNav() => BottomNavigationBar(
    currentIndex: currentTab,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    onTap: onBottomSelect,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kursus'),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blog'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
    ],
  );

  // ――― Filter chip ―――
  Widget _filterRow() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children:
          filters
              .map(
                (f) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(f),
                    selected: f == selectedFilter,
                    selectedColor: Colors.deepPurple,
                    labelStyle: TextStyle(
                      color:
                          f == selectedFilter ? Colors.white : Colors.black87,
                    ),
                    onSelected: (_) => onFilterChange(f),
                  ),
                ),
              )
              .toList(),
    ),
  );

  // ――― List artikel ―――
  Widget _articleList() => ListView.separated(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: articles.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (_, i) => _articleCard(i, articles[i]),
  );

  // ――― Kartu artikel + bookmark ―――
  Widget _articleCard(int index, Map<String, dynamic> a) => GestureDetector(
    onTap: () => onArticleTap(a),
    child: LayoutBuilder(
      builder: (_, box) {
        // gambar menyesuaikan lebar max 30 % kartu
        final imgSide = box.maxWidth * 0.3;
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              _thumbnail(a, imgSide),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a['title'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (a['snippet'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        a['snippet'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Text(
                      '${a['category']}  •  ${a['date']}',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  bookmarked.contains(index)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color:
                      bookmarked.contains(index)
                          ? Colors.deepPurple
                          : Colors.grey,
                ),
                onPressed: () => onBookmarkToggle(index),
              ),
            ],
          ),
        );
      },
    ),
  );

  // ――― Thumbnail adaptif ―――
  Widget _thumbnail(Map<String, dynamic> a, double side) {
    Widget img;
    if (a['imageAsset'] != null) {
      img = Image.asset(
        a['imageAsset'],
        height: side,
        width: side,
        fit: BoxFit.cover,
      );
    } else if (a['imageUrl'] != null) {
      img = Image.network(
        a['imageUrl'],
        height: side,
        width: side,
        fit: BoxFit.cover,
      );
    } else {
      img = const Icon(Icons.menu_book, color: Colors.deepPurple, size: 30);
    }
    return ClipRRect(borderRadius: BorderRadius.circular(12), child: img);
  }
}
