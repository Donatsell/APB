import 'package:flutter/material.dart';

/// Panggil fungsi ini di mana saja:
/// ```dart
/// onPressed: () => openMyCourseScreen(context)
/// ```
void openMyCourseScreen(BuildContext context) {
  Navigator.pushNamed(context, '/my-courses');
}
