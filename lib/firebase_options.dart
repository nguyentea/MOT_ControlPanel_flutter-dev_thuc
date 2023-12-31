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
    apiKey: 'AIzaSyAGEyO4ZN7gdrvuqY4Vd1SMMCUVmt6UDno',
    appId: '1:91945409393:web:1b17b16a8ad8d978bb74d0',
    messagingSenderId: '91945409393',
    projectId: 'aaaa-dbb41',
    authDomain: 'aaaa-dbb41.firebaseapp.com',
    databaseURL: 'https://aaaa-dbb41-default-rtdb.firebaseio.com',
    storageBucket: 'aaaa-dbb41.appspot.com',
    measurementId: 'G-V374LENXFS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMHsd-td8eWx-XihlzihgRx9C-fG45B-A',
    appId: '1:91945409393:android:067eac33a503b363bb74d0',
    messagingSenderId: '91945409393',
    projectId: 'aaaa-dbb41',
    databaseURL: 'https://aaaa-dbb41-default-rtdb.firebaseio.com',
    storageBucket: 'aaaa-dbb41.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqFDsOAHPw_HvOXhvmPG49G-Lhucp5JUY',
    appId: '1:91945409393:ios:cf53b51e64b41b77bb74d0',
    messagingSenderId: '91945409393',
    projectId: 'aaaa-dbb41',
    databaseURL: 'https://aaaa-dbb41-default-rtdb.firebaseio.com',
    storageBucket: 'aaaa-dbb41.appspot.com',
    androidClientId: '91945409393-879eb4r19c3f9tqe9i705qgi17709f4o.apps.googleusercontent.com',
    iosClientId: '91945409393-f6t9o78fr0usv6k2kuamph5pcokcnmao.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluttercontrolpanel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqFDsOAHPw_HvOXhvmPG49G-Lhucp5JUY',
    appId: '1:91945409393:ios:cf53b51e64b41b77bb74d0',
    messagingSenderId: '91945409393',
    projectId: 'aaaa-dbb41',
    databaseURL: 'https://aaaa-dbb41-default-rtdb.firebaseio.com',
    storageBucket: 'aaaa-dbb41.appspot.com',
    androidClientId: '91945409393-879eb4r19c3f9tqe9i705qgi17709f4o.apps.googleusercontent.com',
    iosClientId: '91945409393-f6t9o78fr0usv6k2kuamph5pcokcnmao.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluttercontrolpanel',
  );
}
