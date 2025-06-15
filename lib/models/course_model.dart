import 'package:flutter/material.dart';

enum CourseIconType { book, computer, science, designServices }

class CourseModel {
  final String title;
  final String subtitle;
  final double rating;
  final String duration;
  final CourseIconType iconType;

  const CourseModel({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.duration,
    required this.iconType,
  });

  static IconData getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'math':
        return Icons.calculate;
      case 'science':
        return Icons.science;
      case 'history':
        return Icons.history;
      case 'english':
        return Icons.book;
      default:
        return Icons.school;
    }
  }

  IconData get icon => getIconForCategory(iconType.name);

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      duration: map['duration'] ?? '',
      iconType: CourseIconType.values.byName(map['iconType'] ?? 'book'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'rating': rating,
      'duration': duration,
      'iconType': iconType.name,
    };
  }
}
