import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Simpan data user baru ke koleksi "users", dan jika role mentor, ke "mentors"
Future<void> saveUserData(
  User user,
  String fullName, {
  String role = 'student',
}) async {
  final userData = {
    'uid': user.uid,
    'email': user.email,
    'name': fullName,
    'role': role,
    'createdAt': FieldValue.serverTimestamp(),
  };

  // Simpan ke koleksi "users"
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .set(userData);

  // Jika mentor, simpan juga ke koleksi "mentors"
  if (role == 'mentor') {
    await FirebaseFirestore.instance.collection('mentors').doc(user.uid).set({
      'uid': user.uid,
      'name': fullName,
      'email': user.email,
      'joinedAt': FieldValue.serverTimestamp(),
      // kamu bisa tambahkan bidang seperti "specialization", "bio", dll di sini
    });
  }
}

/// Ambil peran/role dari user berdasarkan dokumen Firestore-nya
Future<String?> getUserRole(User user) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  return snapshot.data()?['role'] as String?;
}
