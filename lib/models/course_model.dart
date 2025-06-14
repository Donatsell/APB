import 'package:flutter/material.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final IconData icon;
  final String category;
  final int duration;
  final String level;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.icon,
    required this.category,
    required this.duration,
    required this.level,
  });

  // If you're creating IconData from codePoint, make it constant
  static const IconData _defaultIcon = Icons.book;

  // Example of how to handle dynamic icons properly
  static IconData getIconFromString(String iconName) {
    switch (iconName) {
      case 'book':
        return Icons.book;
      case 'code':
        return Icons.code;
      case 'computer':
        return Icons.computer;
      case 'school':
        return Icons.school;
      default:
        return Icons.book;
    }
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      // Use the static method instead of dynamic IconData creation
      icon: getIconFromString(map['iconName'] ?? 'book'),
      category: map['category'] ?? '',
      duration: map['duration'] ?? 0,
      level: map['level'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'iconName': _getIconName(icon),
      'category': category,
      'duration': duration,
      'level': level,
    };
  }

  String _getIconName(IconData icon) {
    if (icon == Icons.book) return 'book';
    if (icon == Icons.code) return 'code';
    if (icon == Icons.computer) return 'computer';
    if (icon == Icons.school) return 'school';
    return 'book';
  }
}
