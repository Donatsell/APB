import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String subtitle;
  final double rating;
  final String duration;
  final IconData icon;

  CourseModel({
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.duration,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'rating': rating,
      'duration': duration,
      'icon': icon.codePoint, // Simpan int
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      title: map['title'],
      subtitle: map['subtitle'],
      rating: map['rating'],
      duration: map['duration'],
      icon: IconData(
        map['icon'],
        fontFamily: 'MaterialIcons', // wajib agar cocok
      ),
    );
  }
}
