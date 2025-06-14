import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String subtitle;
  final double rating;
  final String duration;
  final String iconName; // Store icon name as string instead of IconData

  const CourseModel({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.duration,
    required this.iconName,
  });

  // Get IconData from iconName
  IconData get icon {
    switch (iconName) {
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
      default:
        return Icons.book;
    }
  }

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
