import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String subtitle;
  final double rating;
  final String duration;
  final String iconName;

  const CourseModel({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.duration,
    required this.iconName,
  });

  // ✅ Use const IconData directly, no Icon() widget!
  static const Map<String, IconData> iconMap = {
    'book': Icons.book,
    'computer': Icons.computer,
    'science': Icons.science,
    'design_services': Icons.design_services,
  };

  // ✅ Getter is fine – accessing const values only
  IconData get icon => iconMap[iconName] ?? Icons.book;

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      duration: map['duration'] ?? '',
      iconName: map['iconName'] ?? 'book',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'rating': rating,
      'duration': duration,
      'iconName': iconName, // ✅ Store iconName (not IconData!)
    };
  }
}
