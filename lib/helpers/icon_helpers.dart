import 'package:flutter/material.dart';

/// Mengubah nama ikon string menjadi IconData dari MaterialIcons
IconData getIconFromString(String? iconName) {
  switch (iconName) {
    case 'code':
      return Icons.code;
    case 'design_services':
      return Icons.design_services;
    case 'school':
      return Icons.school;
    case 'laptop_mac':
      return Icons.laptop_mac;
    case 'psychology':
      return Icons.psychology;
    case 'science':
      return Icons.science;
    case 'palette':
      return Icons.palette;
    case 'edit':
      return Icons.edit;
    case 'language':
      return Icons.language;
    case 'calculate':
      return Icons.calculate;
    case 'history_edu':
      return Icons.history_edu;
    case 'music_note':
      return Icons.music_note;
    case 'emoji_objects':
      return Icons.emoji_objects;
    case 'fitness_center':
      return Icons.fitness_center;
    case 'auto_stories':
      return Icons.auto_stories;
    case 'book':
      return Icons.book;
    case 'video_library':
      return Icons.video_library;
    case 'web':
      return Icons.web;
    case 'camera_alt':
      return Icons.camera_alt;
    case 'draw':
      return Icons.draw;
    case 'business':
      return Icons.business;
    case 'emoji_emotions':
      return Icons.emoji_emotions;
    case 'memory':
      return Icons.memory;
    case 'brush':
      return Icons.brush;
    case 'timeline':
      return Icons.timeline;
    default:
      return Icons.help_outline; // fallback jika tidak ditemukan
  }
}
