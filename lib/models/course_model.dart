import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String subtitle;
  final double rating;
  final String duration;
  final IconData icon;

  const CourseModel({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.duration,
    required this.icon,
  });

  // Add getter for iconName
  String get iconName {
    if (icon == Icons.book) return 'book';
    if (icon == Icons.computer) return 'computer';
    if (icon == Icons.science) return 'science';
    if (icon == Icons.design_services) return 'design_services';
    return 'book'; // default
  }

  // Factory constructor for creating from Map
  factory CourseModel.fromMap(Map<String, dynamic> map) {
    IconData iconData;
    switch (map['iconName'] ?? 'book') {
      case 'book':
        iconData = Icons.book;
        break;
      case 'computer':
        iconData = Icons.computer;
        break;
      case 'science':
        iconData = Icons.science;
        break;
      case 'design_services':
        iconData = Icons.design_services;
        break;
      default:
        iconData = Icons.book;
    }

    return CourseModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      duration: map['duration'] ?? '',
      icon: iconData,
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
