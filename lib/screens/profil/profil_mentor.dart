// import 'package:flutter/material.dart';
// import 'package:lucide_icons/lucide_icons.dart'; // Tambahkan jika perlu

// class ProfilMentorScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // Profile Header
//               SizedBox(height: 16),
//               Text("Instructor", style: TextStyle(color: Colors.grey)),
//               SizedBox(height: 4),
//               Text(
//                 "Paulo Maldini",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),

//               SizedBox(height: 16),
//               CircleAvatar(
//                 radius: 40,
//                 backgroundColor: Colors.deepPurple,
//                 child: Icon(Icons.person, size: 40, color: Colors.white),
//               ),
//               SizedBox(height: 12),

//               // Role tag
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'UI/UX Designer',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     SizedBox(width: 4),
//                     Icon(Icons.edit, color: Colors.white, size: 16),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24),

//               // Stats
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   StatBox(title: "5", subtitle: "Active Course"),
//                   StatBox(
//                     title: "120",
//                     subtitle: "Students",
//                     icon: Icons.people,
//                   ),
//                   StatBox(title: "4.8⭐", subtitle: "Rating"),
//                 ],
//               ),

//               SizedBox(height: 24),
//               Divider(),

//               // My Course
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: Text(
//                     "My Course",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     // Course image placeholder
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.deepPurple.shade200,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Icon(Icons.design_services, color: Colors.white),
//                     ),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "UI/UX Design Foundations",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text("👥 65 Student", style: TextStyle(fontSize: 12)),
//                         ],
//                       ),
//                     ),
//                     Text("Manage", style: TextStyle(color: Colors.deepPurple)),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 24),
//               Divider(),

//               // About
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: Text(
//                     "About",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                 ),
//               ),
//               Text(
//                 "I'm an experienced instructor in UI/UX and Web Development. "
//                 "Passionate about sharing knowledge and guiding students "
//                 "to become industry-ready professionals.",
//                 textAlign: TextAlign.justify,
//               ),

//               SizedBox(height: 24),

//               // Social media icons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SocialIcon(icon: Icons.linked_camera, color: Colors.blue),
//                   SocialIcon(icon: Icons.camera_alt, color: Colors.pink),
//                   SocialIcon(icon: Icons.whatsapp, color: Colors.green),
//                 ],
//               ),
//               SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class StatBox extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData? icon;

//   const StatBox({required this.title, required this.subtitle, this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         icon != null
//             ? Icon(icon, color: Colors.deepPurple)
//             : Text(
//               title,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.deepPurple,
//               ),
//             ),
//         SizedBox(height: 4),
//         Text(subtitle, style: TextStyle(color: Colors.black54)),
//       ],
//     );
//   }
// }

// class SocialIcon extends StatelessWidget {
//   final IconData icon;
//   final Color color;

//   const SocialIcon({required this.icon, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       child: CircleAvatar(
//         backgroundColor: color.withOpacity(0.1),
//         child: Icon(icon, color: color),
//       ),
//     );
//   }
// }
