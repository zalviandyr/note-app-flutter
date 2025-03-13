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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTfAnEzW6ki9ke4QLPK-w31cveyJnH6TY',
    appId: '1:44291776057:android:f410c7f10c9a1e0577f7e8',
    messagingSenderId: '44291776057',
    projectId: 'note-pocket',
    databaseURL: 'https://note-pocket-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'note-pocket.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMiLn2gP-OlYxZ9BIzBRxQ9zr4CzQobg0',
    appId: '1:44291776057:ios:9d6998fb60611bf077f7e8',
    messagingSenderId: '44291776057',
    projectId: 'note-pocket',
    databaseURL: 'https://note-pocket-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'note-pocket.firebasestorage.app',
    iosBundleId: 'com.note.pocket',
  );

}