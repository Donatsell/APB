import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String subtitle;
  final double rating;
  final String duration;
  final IconData icon; // Change to IconData directly

  const CourseModel({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.duration,
    required this.icon, // Use IconData directly
  });

  // Factory constructor for creating from Map
  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      duration: map['duration'] ?? '',
      icon: _getIconFromString(map['iconName'] ?? 'book'),
    );
  }

  // Static method to convert string to IconData
  static IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'computer':
        return Icons.computer;
      case 'design_services':
        return Icons.design_services;
      case 'science':
        return Icons.science;
      case 'calculate':
        return Icons.calculate;
      case 'palette':
        return Icons.palette;
      default:
        return Icons.book;
    }
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'rating': rating,
      'duration': duration,
      'iconName': _getStringFromIcon(icon),
    };
  }

  // Helper method to convert IconData back to string
  static String _getStringFromIcon(IconData icon) {
    if (icon == Icons.computer) return 'computer';
    if (icon == Icons.design_services) return 'design_services';
    if (icon == Icons.science) return 'science';
    if (icon == Icons.calculate) return 'calculate';
    if (icon == Icons.palette) return 'palette';
    return 'book';
  }
}
