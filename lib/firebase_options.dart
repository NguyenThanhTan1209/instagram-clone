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
    apiKey: 'AIzaSyC7SyrfSxl6nPQrxET1sqIBmX-dg3K1oqI',
    appId: '1:1017869787048:web:2928f482cc6ad4b6a0079d',
    messagingSenderId: '1017869787048',
    projectId: 'instagram-clone-7e660',
    authDomain: 'instagram-clone-7e660.firebaseapp.com',
    storageBucket: 'instagram-clone-7e660.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAijzRuUGvexY9kCPSzg3BbzsgG45qjmO0',
    appId: '1:1017869787048:android:b2cadbfc32bbbca6a0079d',
    messagingSenderId: '1017869787048',
    projectId: 'instagram-clone-7e660',
    databaseURL: 'https://instagram-clone-7e660-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'instagram-clone-7e660.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA66xQafhypwmtP-5htDcDtqqkKADK6S18',
    appId: '1:1017869787048:ios:8270484491d92a84a0079d',
    messagingSenderId: '1017869787048',
    projectId: 'instagram-clone-7e660',
    databaseURL: 'https://instagram-clone-7e660-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'instagram-clone-7e660.appspot.com',
    androidClientId: '1017869787048-s1ef2j7jqdppc1utqugv9217q2g870j9.apps.googleusercontent.com',
    iosClientId: '1017869787048-glpbgsi3h8kshckp29rvkj6bi1pdhp4b.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA66xQafhypwmtP-5htDcDtqqkKADK6S18',
    appId: '1:1017869787048:ios:8270484491d92a84a0079d',
    messagingSenderId: '1017869787048',
    projectId: 'instagram-clone-7e660',
    storageBucket: 'instagram-clone-7e660.appspot.com',
    iosBundleId: 'com.example.instagramClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC7SyrfSxl6nPQrxET1sqIBmX-dg3K1oqI',
    appId: '1:1017869787048:web:70827e52173bbf79a0079d',
    messagingSenderId: '1017869787048',
    projectId: 'instagram-clone-7e660',
    authDomain: 'instagram-clone-7e660.firebaseapp.com',
    storageBucket: 'instagram-clone-7e660.appspot.com',
  );

}