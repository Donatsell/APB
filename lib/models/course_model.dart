import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String subtitle;
  final double rating;
  final String duration;
  final String iconName; // Store icon name as string

  const CourseModel({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.duration,
    required this.iconName,
  });

  // Use constant icons to avoid tree shaking issues
  static const Map<String, IconData> _iconMap = {
    'book': Icons.book,
    'computer': Icons.computer,
    'science': Icons.science,
    'design_services': Icons.design_services,
    'calculate': Icons.calculate,
    'palette': Icons.palette,
  };

  // Getter that returns constant IconData
  IconData get icon => _iconMap[iconName] ?? Icons.book;

  // Factory constructor for creating from Map
  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      duration: map['duration'] ?? '',
      iconName: map['iconName'] ?? 'book',
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'rating': rating,
      'duration': duration,
      'iconName': iconName,
    };
  }
}
