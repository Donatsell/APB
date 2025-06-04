import 'package:flutter/material.dart';
import '../../helpers/icon_helpers.dart';

class HomeBaseScreen extends StatefulWidget {
  final String greeting;
  final VoidCallback onProfileTap;
  final int selectedTab;
  final VoidCallback? onCourseTabTap;
  final VoidCallback? onBlogTabTap;
  final List<Map<String, dynamic>> courses;
  final void Function(Map<String, dynamic>) onCourseTap;
  final String? subtitle;
  final Widget? promoCard;
  final List<String>? chipLabels;
  final String? selectedChip;
  final Function(String)? onChipSelected;
  final bool enableSearch;
  final String? searchHint;
  final List<BottomNavigationBarItem>? bottomNavItems;

  const HomeBaseScreen({
    super.key,
    required this.greeting,
    required this.courses,
    required this.onProfileTap,
    required this.onCourseTap,
    this.selectedTab = 0,
    this.onCourseTabTap,
    this.onBlogTabTap,
    this.promoCard,
    this.chipLabels,
    this.selectedChip,
    this.onChipSelected,
    this.subtitle,
    this.enableSearch = true,
    this.searchHint = 'Search...',
    this.bottomNavItems,
  });

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  late TextEditingController _searchController;
  late String _selectedChip;
  List<Map<String, dynamic>> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedChip = widget.selectedChip ?? (widget.chipLabels?.first ?? '');
    _filterCourses();
  }

  @override
  void didUpdateWidget(HomeBaseScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.courses != widget.courses ||
        oldWidget.selectedChip != widget.selectedChip) {
      _filterCourses();
    }
  }

  void _filterCourses() {
    _filteredCourses =
        widget.courses.where((course) {
          final matchesSearch =
              course['title']?.toString().toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) ??
              true;

          final matchesChip =
              _selectedChip == 'Semua' ||
              _selectedChip.isEmpty ||
              course['title']?.toString().contains(_selectedChip) == true;

          return matchesSearch && matchesChip;
        }).toList();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _filterCourses();
    });
  }

  void _onChipSelected(String chip) {
    setState(() {
      _selectedChip = chip;
      _filterCourses();
    });
    widget.onChipSelected?.call(chip);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 16),
              Text(
                widget.greeting,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (widget.subtitle != null)
                Text(
                  widget.subtitle!,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              const SizedBox(height: 16),
              if (widget.promoCard != null) widget.promoCard!,
              if (widget.promoCard != null) const SizedBox(height: 16),
              if (widget.enableSearch) _searchBar(),
              if (widget.enableSearch) const SizedBox(height: 16),
              if (widget.chipLabels != null && widget.chipLabels!.isNotEmpty)
                _chipRow(),
              if (widget.chipLabels != null && widget.chipLabels!.isNotEmpty)
                const SizedBox(height: 16),
              Expanded(child: _courseList()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _header() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.grid_view, color: Colors.purple, size: 24),
      ),
      GestureDetector(
        onTap: widget.onProfileTap,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.purple,
          child: const Icon(Icons.person, color: Colors.white, size: 24),
        ),
      ),
    ],
  );

  Widget _searchBar() => Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      controller: _searchController,
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        hintText: widget.searchHint,
        hintStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
        filled: false,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    ),
  );

  Widget _chipRow() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children:
          widget.chipLabels!.map((label) {
            final isSelected = label == _selectedChip;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => _onChipSelected(label),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.purple : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    ),
  );

  Widget _courseList() => ListView.separated(
    itemCount: _filteredCourses.length,
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (_, i) {
      final c = _filteredCourses[i];
      return GestureDetector(
        onTap: () => widget.onCourseTap(c),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  c['icon'] is IconData
                      ? c['icon']
                      : getIconFromString(c['icon']),
                  size: 24,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (c['subtitle'] != null)
                      Text(
                        c['subtitle'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                  ],
                ),
              ),
              if (c['rating'] != null || c['duration'] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (c['rating'] != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${c['rating']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    if (c['duration'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${c['duration']}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ],
                ),
            ],
          ),
        ),
      );
    },
  );

  BottomNavigationBar _bottomBar() => BottomNavigationBar(
    currentIndex: widget.selectedTab,
    selectedItemColor: Colors.purple,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    elevation: 8,
    onTap: (i) {
      switch (i) {
        case 1:
          widget.onCourseTabTap?.call();
          break;
        case 2:
          widget.onBlogTabTap?.call();
          break;
        case 3:
          widget.onProfileTap();
          break;
      }
    },
    items:
        widget.bottomNavItems ??
        const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Course'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blogs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
  );
}
