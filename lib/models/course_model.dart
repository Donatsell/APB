import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String subtitle;
  final double rating;
  final String duration;
  final IconData icon;
  final String iconKey; // Store the icon key directly

  const CourseModel({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.duration,
    required this.icon,
    required this.iconKey,
  });

  // Static constant map for icons
  static const Map<String, IconData> _iconMap = {
    'book': Icons.book,
    'computer': Icons.computer,
    'science': Icons.science,
    'design_services': Icons.design_services,
    'school': Icons.school,
    'calculate': Icons.calculate,
    'palette': Icons.palette,
    'music_note': Icons.music_note,
    'sports': Icons.sports,
  };

  // Simple getter that returns the stored key
  String get iconName => iconKey;

  // Factory constructor for creating from Map
  factory CourseModel.fromMap(Map<String, dynamic> map) {
    final iconKey = map['iconName'] ?? 'book';
    final iconData = _iconMap[iconKey] ?? Icons.book;

    return CourseModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      duration: map['duration'] ?? '',
      icon: iconData,
      iconKey: iconKey,
    );
  }

  // Factory constructor for creating with icon name
  factory CourseModel.withIconName({
    required String title,
    required String subtitle,
    required double rating,
    required String duration,
    required String iconName,
  }) {
    final iconData = _iconMap[iconName] ?? Icons.book;

    return CourseModel(
      title: title,
      subtitle: subtitle,
      rating: rating,
      duration: duration,
      icon: iconData,
      iconKey: iconName,
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'rating': rating,
      'duration': duration,
      'iconName': iconKey,
    };
  }
}
