// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart

/// // ...
// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCQ6pcqY59APyyiFKXxXQ2cxEsU7TjE-BI',
    appId: '1:619719555041:web:4b4e93c6b710256fa044a0',
    messagingSenderId: '619719555041',
    projectId: 'tugasprojekbesar',
    authDomain: 'tugasprojekbesar.firebaseapp.com',
    storageBucket: 'tugasprojekbesar.firebasestorage.app',
    measurementId: 'G-BFH29S1VEP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbfqlerfaoLTeYl8lxO_GynJ3RXiehcvs',
    appId: '1:619719555041:android:a470dae02392f14aa044a0',
    messagingSenderId: '619719555041',
    projectId: 'tugasprojekbesar',
    storageBucket: 'tugasprojekbesar.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDH3L-1tv3z_eLTq5MP-tZClRxveJD6IR4',
    appId: '1:619719555041:ios:ba1e13b3909f213ea044a0',
    messagingSenderId: '619719555041',
    projectId: 'tugasprojekbesar',
    storageBucket: 'tugasprojekbesar.firebasestorage.app',
    iosBundleId: 'com.example.apbTaNew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDH3L-1tv3z_eLTq5MP-tZClRxveJD6IR4',
    appId: '1:619719555041:ios:ba1e13b3909f213ea044a0',
    messagingSenderId: '619719555041',
    projectId: 'tugasprojekbesar',
    storageBucket: 'tugasprojekbesar.firebasestorage.app',
    iosBundleId: 'com.example.apbTaNew',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCQ6pcqY59APyyiFKXxXQ2cxEsU7TjE-BI',
    appId: '1:619719555041:web:a4f1fc5fe66f8307a044a0',
    messagingSenderId: '619719555041',
    projectId: 'tugasprojekbesar',
    authDomain: 'tugasprojekbesar.firebaseapp.com',
    storageBucket: 'tugasprojekbesar.firebasestorage.app',
    measurementId: 'G-YQSSSLHR5Z',
  );
}
