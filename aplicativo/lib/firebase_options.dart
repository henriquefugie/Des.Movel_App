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
        return macos;
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
    apiKey: 'AIzaSyB7pv8FUXeYiYvR9LbgoumyP6BqOLVPFeg',
    appId: '1:181965668938:web:f3e8957bd46cb837731cb3',
    messagingSenderId: '181965668938',
    projectId: 'aplicativo-trabalho',
    authDomain: 'aplicativo-trabalho.firebaseapp.com',
    storageBucket: 'aplicativo-trabalho.appspot.com',
    measurementId: 'G-1BTKFWQTNR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB30OaHXp_Nsr1bFBCZl7Ttnfm60U5aVaY',
    appId: '1:181965668938:android:75b5c15865e2d7fc731cb3',
    messagingSenderId: '181965668938',
    projectId: 'aplicativo-trabalho',
    storageBucket: 'aplicativo-trabalho.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGe5VJFdO5n3WRGL0d2G5Xp4C82Cnlz3c',
    appId: '1:181965668938:ios:91dee3e9b68f0d39731cb3',
    messagingSenderId: '181965668938',
    projectId: 'aplicativo-trabalho',
    storageBucket: 'aplicativo-trabalho.appspot.com',
    iosClientId: '181965668938-7bnioavcks53o5n3ka382pqssg8svlhv.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGe5VJFdO5n3WRGL0d2G5Xp4C82Cnlz3c',
    appId: '1:181965668938:ios:91dee3e9b68f0d39731cb3',
    messagingSenderId: '181965668938',
    projectId: 'aplicativo-trabalho',
    storageBucket: 'aplicativo-trabalho.appspot.com',
    iosClientId: '181965668938-7bnioavcks53o5n3ka382pqssg8svlhv.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication3',
  );
}
