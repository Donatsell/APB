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
      case 'book':
        return Icons.book;
      case 'computer':
        return Icons.computer;
      case 'science':
        return Icons.science;
      case 'design_services':
        return Icons.design_services;
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
      'icon': icon,
    };
  }
}
