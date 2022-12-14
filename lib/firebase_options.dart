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
    apiKey: 'AIzaSyC3GOJs6yCCgbJQDuD4nlikOyH1hsaGNUE',
    appId: '1:524054772145:web:ba5adf64acc9fa938ae590',
    messagingSenderId: '524054772145',
    projectId: 'feedapp-f37c4',
    authDomain: 'feedapp-f37c4.firebaseapp.com',
    databaseURL: 'https://feedapp-f37c4.firebaseio.com',
    storageBucket: 'feedapp-f37c4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2X14edRZjsKwsrjsg0xMEsNhgVMGGjz8',
    appId: '1:524054772145:android:aac2bdc6c9fa390e8ae590',
    messagingSenderId: '524054772145',
    projectId: 'feedapp-f37c4',
    databaseURL: 'https://feedapp-f37c4.firebaseio.com',
    storageBucket: 'feedapp-f37c4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2I6eUDjn3TT2eFWjs-KAxqdce9QGDJIc',
    appId: '1:524054772145:ios:eb03633e15810d368ae590',
    messagingSenderId: '524054772145',
    projectId: 'feedapp-f37c4',
    databaseURL: 'https://feedapp-f37c4.firebaseio.com',
    storageBucket: 'feedapp-f37c4.appspot.com',
    androidClientId: '524054772145-farr9cfu8tddgmsklt28vuj0e6amluae.apps.googleusercontent.com',
    iosClientId: '524054772145-3vgikmhuk6nncvcmndn0ouhrudu0ogns.apps.googleusercontent.com',
    iosBundleId: 'com.example.tutorCloud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2I6eUDjn3TT2eFWjs-KAxqdce9QGDJIc',
    appId: '1:524054772145:ios:eb03633e15810d368ae590',
    messagingSenderId: '524054772145',
    projectId: 'feedapp-f37c4',
    databaseURL: 'https://feedapp-f37c4.firebaseio.com',
    storageBucket: 'feedapp-f37c4.appspot.com',
    androidClientId: '524054772145-farr9cfu8tddgmsklt28vuj0e6amluae.apps.googleusercontent.com',
    iosClientId: '524054772145-3vgikmhuk6nncvcmndn0ouhrudu0ogns.apps.googleusercontent.com',
    iosBundleId: 'com.example.tutorCloud',
  );
}
