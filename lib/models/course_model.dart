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

  // Simple method to convert to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'rating': rating,
      'duration': duration,
    };
  }
}
