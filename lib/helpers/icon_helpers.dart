import 'package:flutter/material.dart';

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
  };

  static IconData getIcon(String iconName) {
    return _iconMap[iconName] ?? Icons.book;
  }

  static String getIconName(IconData icon) {
    for (final entry in _iconMap.entries) {
      if (entry.value == icon) {
        return entry.key;
      }
    }
    return 'book';
  }
}
