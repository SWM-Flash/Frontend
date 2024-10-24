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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDQv5N6ybmcjyHZgCVNj3ksi_JB-_rA1uo',
    appId: '1:723913284357:web:3e4488db09c512af9a756c',
    messagingSenderId: '723913284357',
    projectId: 'flash-43a2b',
    authDomain: 'flash-43a2b.firebaseapp.com',
    storageBucket: 'flash-43a2b.appspot.com',
    measurementId: 'G-XDK7HQH4S6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA9dMNNPV2nsB-WoKjDy4KQ-B8TCM0BTLI',
    appId: '1:723913284357:android:1a52b4cdb11aa8329a756c',
    messagingSenderId: '723913284357',
    projectId: 'flash-43a2b',
    storageBucket: 'flash-43a2b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmdLuvB1cyHUJcRdE5yb5mxD_0wOk8E0o',
    appId: '1:723913284357:ios:604ae04899ef8b889a756c',
    messagingSenderId: '723913284357',
    projectId: 'flash-43a2b',
    storageBucket: 'flash-43a2b.appspot.com',
    iosBundleId: 'com.example.flash',
  );

}