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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgADSl4kNRPODpis7cXoBAqiY0in3vV0I',
    appId: '1:469529767335:android:033ac3c9b58b4a5a1e9a82',
    messagingSenderId: '469529767335',
    projectId: 'bruno-s-kitchen',
    storageBucket: 'bruno-s-kitchen.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDAB2HmwNQc-F-Zl3WDox1t2VCU4vyZI3o',
    appId: '1:469529767335:ios:dbd875a7499feceb1e9a82',
    messagingSenderId: '469529767335',
    projectId: 'bruno-s-kitchen',
    storageBucket: 'bruno-s-kitchen.appspot.com',
    androidClientId: '469529767335-9hapi53j6lskfg6urssl7cb3ikstn90t.apps.googleusercontent.com',
    iosClientId: '469529767335-7ckkdk4mcqpiouoka6k5jjr30r1j4mlg.apps.googleusercontent.com',
    iosBundleId: 'com.bruno.kitchen',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA8PQF5x1tKEAZ3O2Ndwv9CCY-IAZDAJ3c',
    appId: '1:469529767335:web:930fad99d548637f1e9a82',
    messagingSenderId: '469529767335',
    projectId: 'bruno-s-kitchen',
    authDomain: 'bruno-s-kitchen.firebaseapp.com',
    storageBucket: 'bruno-s-kitchen.appspot.com',
    measurementId: 'G-7W89XQG5SG',
  );

}