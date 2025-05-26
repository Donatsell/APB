import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveUserData(
  User user,
  String fullName, {
  String role = 'student',
}) async {
  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'uid': user.uid,
    'email': user.email,
    'name': fullName,
    'role': role, // ⬅️ Tambahkan ini
    'createdAt': FieldValue.serverTimestamp(),
  });
}

Future<String?> getUserRole(User user) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  return snapshot.data()?['role'] as String?;
}
