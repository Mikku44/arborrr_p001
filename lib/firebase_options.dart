// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCZbif047R2r5dVtGgKCAfreF39fCadiB0',
    appId: '1:934169145013:web:ae2f0f0f02e048ee0b98fc',
    messagingSenderId: '934169145013',
    projectId: 'arborrr-p001a',
    authDomain: 'arborrr-p001a.firebaseapp.com',
    storageBucket: 'arborrr-p001a.appspot.com',
    measurementId: 'G-WWVSLJTJDY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWcpANJOzjCM9PVnsoPFD-gBrYk7-H3o8',
    appId: '1:934169145013:android:b5652cd112354ecc0b98fc',
    messagingSenderId: '934169145013',
    projectId: 'arborrr-p001a',
    storageBucket: 'arborrr-p001a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAb3dtfdNjpOgqe09E4I4AyovbSx1WY5yI',
    appId: '1:934169145013:ios:96aa4054be123ed30b98fc',
    messagingSenderId: '934169145013',
    projectId: 'arborrr-p001a',
    storageBucket: 'arborrr-p001a.appspot.com',
    iosClientId: '934169145013-gk01027kke109ffqv6hbf32e0adknain.apps.googleusercontent.com',
    iosBundleId: 'com.example.arborrrP001',
  );
}
