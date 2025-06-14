import 'package:flutter/material.dart';

class AppIcons {
  static const IconData book = Icons.book;
  static const IconData computer = Icons.computer;
  static const IconData science = Icons.science;
  static const IconData designServices = Icons.design_services;

  static const Map<String, IconData> iconMap = {
    'book': book,
    'computer': computer,
    'science': science,
    'design_services': designServices,
  };

  static IconData getIcon(String iconName) {
    return iconMap[iconName] ?? book;
  }
}
