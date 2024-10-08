// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
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
    apiKey: 'AIzaSyAAB6bSrwsCJtM_7xB1kAjVQcF1wvEZAHE',
    appId: '1:1008219463599:web:3fc0cb229788a782e5d95a',
    messagingSenderId: '1008219463599',
    projectId: 'e-learning-7b6b5',
    authDomain: 'e-learning-7b6b5.firebaseapp.com',
    storageBucket: 'e-learning-7b6b5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCo75CSFU6IYhhzvOiolhRKW-37iiMClEQ',
    appId: '1:1008219463599:android:67fcc02c800e1788e5d95a',
    messagingSenderId: '1008219463599',
    projectId: 'e-learning-7b6b5',
    storageBucket: 'e-learning-7b6b5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYuQngZsKyZmNtvTFX4cfMj_nO-48u1wc',
    appId: '1:1008219463599:ios:9a250fa77fde8f8ae5d95a',
    messagingSenderId: '1008219463599',
    projectId: 'e-learning-7b6b5',
    storageBucket: 'e-learning-7b6b5.appspot.com',
    iosBundleId: 'com.example.project1st',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYuQngZsKyZmNtvTFX4cfMj_nO-48u1wc',
    appId: '1:1008219463599:ios:9a250fa77fde8f8ae5d95a',
    messagingSenderId: '1008219463599',
    projectId: 'e-learning-7b6b5',
    storageBucket: 'e-learning-7b6b5.appspot.com',
    iosBundleId: 'com.example.project1st',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAAB6bSrwsCJtM_7xB1kAjVQcF1wvEZAHE',
    appId: '1:1008219463599:web:96a63cb8c46904e2e5d95a',
    messagingSenderId: '1008219463599',
    projectId: 'e-learning-7b6b5',
    authDomain: 'e-learning-7b6b5.firebaseapp.com',
    storageBucket: 'e-learning-7b6b5.appspot.com',
  );
}
