// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyA3s1IUYP8LdqvEu-3_4_8gWd5kugdlzdk',
    appId: '1:446027425054:web:63acee7252f296d6a6950f',
    messagingSenderId: '446027425054',
    projectId: 'online-shopping-47249',
    authDomain: 'online-shopping-47249.firebaseapp.com',
    storageBucket: 'online-shopping-47249.appspot.com',
    measurementId: 'G-3MC7MW3NWS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_vAkBrinHOGthY98rOJ1pscOW7zFl5d8',
    appId: '1:446027425054:android:2d7349848b5ccbb6a6950f',
    messagingSenderId: '446027425054',
    projectId: 'online-shopping-47249',
    storageBucket: 'online-shopping-47249.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDR9IupZQ20E5Re_EuQW8WSJcsq1WnBXds',
    appId: '1:446027425054:ios:5eb23328da752211a6950f',
    messagingSenderId: '446027425054',
    projectId: 'online-shopping-47249',
    storageBucket: 'online-shopping-47249.appspot.com',
    androidClientId: '446027425054-blt0rtg0i9pt6v8j201dnbt89kskmcfo.apps.googleusercontent.com',
    iosClientId: '446027425054-ui53h325b60621ohgidmpnvndu81u6am.apps.googleusercontent.com',
    iosBundleId: 'com.example.onlineShopping',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDR9IupZQ20E5Re_EuQW8WSJcsq1WnBXds',
    appId: '1:446027425054:ios:5eb23328da752211a6950f',
    messagingSenderId: '446027425054',
    projectId: 'online-shopping-47249',
    storageBucket: 'online-shopping-47249.appspot.com',
    androidClientId: '446027425054-blt0rtg0i9pt6v8j201dnbt89kskmcfo.apps.googleusercontent.com',
    iosClientId: '446027425054-ui53h325b60621ohgidmpnvndu81u6am.apps.googleusercontent.com',
    iosBundleId: 'com.example.onlineShopping',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA3s1IUYP8LdqvEu-3_4_8gWd5kugdlzdk',
    appId: '1:446027425054:web:2719550921eb9944a6950f',
    messagingSenderId: '446027425054',
    projectId: 'online-shopping-47249',
    authDomain: 'online-shopping-47249.firebaseapp.com',
    storageBucket: 'online-shopping-47249.appspot.com',
    measurementId: 'G-JWBVDWKK60',
  );
}
