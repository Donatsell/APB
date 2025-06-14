import 'package:flutter/material.dart';

// ✅ Static constant map - this is tree-shake friendly
class IconHelper {
  static const Map<String, IconData> _iconMap = {
    'computer': Icons.computer,
    'design_services': Icons.design_services,
    'book': Icons.book,
    'code': Icons.code,
    'school': Icons.school,
    'manage_accounts': Icons.manage_accounts,
    'support_agent': Icons.support_agent,
    'home': Icons.home,
    'article': Icons.article,
    'person': Icons.person,
    'laptop_chromebook': Icons.laptop_chromebook,
    'grid_view': Icons.grid_view,
    'search': Icons.search,
    'star': Icons.star,
  };

  // ✅ This is safe for tree-shaking
  static IconData getIcon(String? iconName) {
    if (iconName == null) return Icons.book;
    return _iconMap[iconName.toLowerCase()] ?? Icons.book;
  }

  // ✅ This is also safe for tree-shaking
  static String getIconName(IconData icon) {
    for (final entry in _iconMap.entries) {
      if (entry.value == icon) {
        return entry.key;
      }
    }
    return 'book';
  }

  // ✅ Get all available icon names
  static List<String> get availableIcons => _iconMap.keys.toList();

  // ✅ Check if icon exists
  static bool hasIcon(String iconName) {
    return _iconMap.containsKey(iconName.toLowerCase());
  }
}

// ✅ Simple function that uses the static map
IconData getIconFromString(String? iconName) {
  return IconHelper.getIcon(iconName);
}

// ✅ Simple function that uses the static map
String getStringFromIcon(IconData icon) {
  return IconHelper.getIconName(icon);
}
