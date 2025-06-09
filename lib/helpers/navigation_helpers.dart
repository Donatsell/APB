import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_data.dart';

/// ═══════════════════════════════════════════════════════════════
/// NAVIGATION HELPERS - Centralized Navigation Functions
/// ═══════════════════════════════════════════════════════════════

/// Navigasi otomatis ke home berdasarkan peran pengguna
Future<void> navigateToHomeBasedOnRole(BuildContext context, User user) async {
  try {
    final role = await getUserRole(user);
    final route = role == 'mentor' ? '/home-mentors' : '/home-student';
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, route);
    }
  } catch (e) {
    // Fallback ke student home jika terjadi error
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home-student');
    }
  }
}

/// ═══════════════════════════════════════════════════════════════
/// MENTOR NAVIGATION FUNCTIONS
/// ═══════════════════════════════════════════════════════════════

/// Navigasi ke home mentor
void navigateToMentorHome(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/home-mentors');

/// Shortcut: ke layar Home Mentor (dengan pushNamed - tidak replace)
void openMentorHomeScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/home-mentors');

/// Navigasi ke layar course mentor
void navigateToMentorCourse(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/course-mentors');

/// Shortcut: ke layar Course Mentor (dengan pushNamed - tidak replace)
void openMentorCourseScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/course-mentors');

/// Navigasi ke layar blogger mentor
void navigateToMentorBlogger(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/blogger-mentors');

/// Shortcut: ke layar Blogger Mentor (dengan pushNamed - tidak replace)
void openMentorBloggerScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/blogger-mentors');

/// Navigasi ke layar profil mentor
void navigateToMentorProfile(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/profil-mentors');

/// Shortcut: ke layar Profil Mentor (dengan pushNamed - tidak replace)
void openMentorProfileScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/profil-mentors');

/// ═══════════════════════════════════════════════════════════════
/// STUDENT NAVIGATION FUNCTIONS
/// ═══════════════════════════════════════════════════════════════

/// Navigasi ke home student
void navigateToStudentHome(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/home-student');

/// Shortcut: ke layar Home Student (dengan pushNamed - tidak replace)
void openStudentHomeScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/home-student');

/// Navigasi ke layar course student
void navigateToStudentCourse(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/course-student');

/// Shortcut: ke layar Course Student (dengan pushNamed - tidak replace)
void openStudentCourseScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/course-student');

/// Navigasi ke layar blogger student
void navigateToStudentBlogger(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/blogger-student');

/// Shortcut: ke layar Blogger Student (dengan pushNamed - tidak replace)
void openStudentBloggerScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/blogger-student');

/// Navigasi ke layar profil student
void navigateToStudentProfile(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/profil-student');

/// Shortcut: ke layar Profil Student (dengan pushNamed - tidak replace)
void openStudentProfileScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/profil-student');

/// ═══════════════════════════════════════════════════════════════
/// LEGACY NAVIGATION FUNCTIONS (BACKWARD COMPATIBILITY)
/// ═══════════════════════════════════════════════════════════════

/// Navigasi ke layar pilih kursus (student) - Legacy
void navigateToCourseSelection(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/courses');

/// Shortcut: ke layar Kursus Saya - Legacy
void openMyCourseScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/my-courses');

/// Navigasi ke detail kursus, dengan membawa argumen
void openCourseDetailScreen(BuildContext context, Map<String, dynamic> course) {
  Navigator.pushNamed(context, '/course-detail', arguments: course);
}

/// Navigasi ke layar buat kursus baru (mentor)
void navigateToCreateCourse(BuildContext context) =>
    Navigator.pushNamed(context, '/create-course');

/// Shortcut: ke layar Blog (dengan pushNamed - tidak replace) - Legacy
void openBlogsScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/blogs');

/// Navigasi ke layar blog utama (dipakai bottom-nav - replace) - Legacy
void navigateToBlogScreen(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/blogs');

/// Navigasi ke detail blog
void openBlogDetailScreen(BuildContext context, Map<String, dynamic> blog) {
  Navigator.pushNamed(context, '/blog-detail', arguments: blog);
}

/// Navigasi ke layar buat blog baru
void navigateToCreateBlog(BuildContext context) =>
    Navigator.pushNamed(context, '/create-blog');

/// Shortcut: ke layar Profil (dengan pushNamed - tidak replace) - Legacy
void openProfileScreen(BuildContext context) =>
    Navigator.pushNamed(context, '/profile');

/// Navigasi ke layar profil (dipakai bottom-nav - replace) - Legacy
void navigateToProfileScreen(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/profile');

/// ═══════════════════════════════════════════════════════════════
/// AUTH NAVIGATION FUNCTIONS
/// ═══════════════════════════════════════════════════════════════

/// Navigasi ke layar edit profil
void navigateToEditProfile(BuildContext context) =>
    Navigator.pushNamed(context, '/edit-profile');

/// Navigasi ke layar login
void navigateToLogin(BuildContext context) =>
    Navigator.pushReplacementNamed(context, '/login');

/// Navigasi ke layar register
void navigateToRegister(BuildContext context) =>
    Navigator.pushNamed(context, '/register');

/// Logout dan kembali ke login
Future<void> logoutAndNavigateToLogin(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false, // Hapus semua route sebelumnya
      );
    }
  } catch (e) {
    // Handle error jika diperlukan
    debugPrint('Logout error: $e');
  }
}

/// ═══════════════════════════════════════════════════════════════
/// ENHANCED BOTTOM NAVIGATION HELPER
/// ═══════════════════════════════════════════════════════════════

/// Helper untuk handle bottom navigation berdasarkan index dan role (Enhanced)
void handleBottomNavigation(
  BuildContext context,
  int index, {
  required String userRole, // 'student' atau 'mentor'
}) {
  switch (index) {
    case 0: // Home
      if (userRole == 'mentor') {
        navigateToMentorHome(context);
      } else {
        navigateToStudentHome(context);
      }
      break;
    case 1: // Course
      if (userRole == 'mentor') {
        navigateToMentorCourse(context);
      } else {
        navigateToStudentCourse(context);
      }
      break;
    case 2: // Blogger
      if (userRole == 'mentor') {
        navigateToMentorBlogger(context);
      } else {
        navigateToStudentBlogger(context);
      }
      break;
    case 3: // Profile
      if (userRole == 'mentor') {
        navigateToMentorProfile(context);
      } else {
        navigateToStudentProfile(context);
      }
      break;
    default:
      break;
  }
}

/// Helper untuk handle bottom navigation dengan pushNamed (tidak replace)
void handleBottomNavigationPush(
  BuildContext context,
  int index, {
  required String userRole, // 'student' atau 'mentor'
}) {
  switch (index) {
    case 0: // Home
      if (userRole == 'mentor') {
        openMentorHomeScreen(context);
      } else {
        openStudentHomeScreen(context);
      }
      break;
    case 1: // Course
      if (userRole == 'mentor') {
        openMentorCourseScreen(context);
      } else {
        openStudentCourseScreen(context);
      }
      break;
    case 2: // Blogger
      if (userRole == 'mentor') {
        openMentorBloggerScreen(context);
      } else {
        openStudentBloggerScreen(context);
      }
      break;
    case 3: // Profile
      if (userRole == 'mentor') {
        openMentorProfileScreen(context);
      } else {
        openStudentProfileScreen(context);
      }
      break;
    default:
      break;
  }
}

/// ═══════════════════════════════════════════════════════════════
/// ROLE-BASED NAVIGATION SHORTCUTS
/// ═══════════════════════════════════════════════════════════════

/// Navigasi ke home berdasarkan role dengan replace
void navigateToRoleBasedHome(BuildContext context, String userRole) {
  if (userRole == 'mentor') {
    navigateToMentorHome(context);
  } else {
    navigateToStudentHome(context);
  }
}

/// Navigasi ke course berdasarkan role dengan replace
void navigateToRoleBasedCourse(BuildContext context, String userRole) {
  if (userRole == 'mentor') {
    navigateToMentorCourse(context);
  } else {
    navigateToStudentCourse(context);
  }
}

/// Navigasi ke blogger berdasarkan role dengan replace
void navigateToRoleBasedBlogger(BuildContext context, String userRole) {
  if (userRole == 'mentor') {
    navigateToMentorBlogger(context);
  } else {
    navigateToStudentBlogger(context);
  }
}

/// Navigasi ke profile berdasarkan role dengan replace
void navigateToRoleBasedProfile(BuildContext context, String userRole) {
  if (userRole == 'mentor') {
    navigateToMentorProfile(context);
  } else {
    navigateToStudentProfile(context);
  }
}

/// ═══════════════════════════════════════════════════════════════
/// UTILITY FUNCTIONS
/// ═══════════════════════════════════════════════════════════════

/// Kembali ke halaman sebelumnya dengan safety check
void safeNavigateBack(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}

/// Navigasi dengan hasil/return value
Future<T?> navigateForResult<T>(
  BuildContext context,
  String routeName, {
  Object? arguments,
}) {
  return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
}

/// Replace current route dengan route baru
void replaceCurrentRoute(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}

/// Clear all routes dan navigasi ke route baru
void clearAndNavigateTo(BuildContext context, String routeName) {
  Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
}

/// Get current route name
String? getCurrentRouteName(BuildContext context) {
  return ModalRoute.of(context)?.settings.name;
}

/// Check if can navigate back
bool canNavigateBack(BuildContext context) {
  return Navigator.canPop(context);
}
