import 'package:flutter/material.dart';

// Function to get IconData from string
IconData getIconFromString(String? iconName) {
  if (iconName == null) return Icons.book;

  switch (iconName.toLowerCase()) {
    case 'computer':
      return Icons.computer;
    case 'design_services':
      return Icons.design_services;
    case 'book':
      return Icons.book;
    case 'code':
      return Icons.code;
    case 'school':
      return Icons.school;
    case 'manage_accounts':
      return Icons.manage_accounts;
    case 'support_agent':
      return Icons.support_agent;
    case 'home':
      return Icons.home;
    case 'article':
      return Icons.article;
    case 'person':
      return Icons.person;
    case 'laptop_chromebook':
      return Icons.laptop_chromebook;
    case 'grid_view':
      return Icons.grid_view;
    case 'search':
      return Icons.search;
    case 'star':
      return Icons.star;
    default:
      return Icons.book;
  }
}

// Function to get string from IconData (optional, for reverse mapping)
String getStringFromIcon(IconData icon) {
  if (icon == Icons.computer) return 'computer';
  if (icon == Icons.design_services) return 'design_services';
  if (icon == Icons.book) return 'book';
  if (icon == Icons.code) return 'code';
  if (icon == Icons.school) return 'school';
  if (icon == Icons.manage_accounts) return 'manage_accounts';
  if (icon == Icons.support_agent) return 'support_agent';
  if (icon == Icons.home) return 'home';
  if (icon == Icons.article) return 'article';
  if (icon == Icons.person) return 'person';
  if (icon == Icons.laptop_chromebook) return 'laptop_chromebook';
  if (icon == Icons.grid_view) return 'grid_view';
  if (icon == Icons.search) return 'search';
  if (icon == Icons.star) return 'star';
  return 'book';
}

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

  static IconData getIcon(String iconName) {
    return _iconMap[iconName.toLowerCase()] ?? Icons.book;
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
