import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'dart:io';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    if (Platform.isAndroid) {
      return android;
    }
    if (Platform.isIOS) {
      return ios;
    }
    if (Platform.isMacOS) {
      return macos;
    }
    if (Platform.isWindows) {
      return windows;
    }
    if (Platform.isLinux) {
      return linux;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-DTZNR2xgFVzpOJ26n-fUw84pTj45pMY',
    appId: '1:483238695077:web:c55319355e747986da7d4c',
    messagingSenderId: '483238695077',
    projectId: 'meky-market',
    authDomain: 'meky-market.firebaseapp.com',
    storageBucket: 'meky-market.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-DTZNR2xgFVzpOJ26n-fUw84pTj45pMY',
    appId: '1:483238695077:android:c55319355e747986da7d4c',
    messagingSenderId: '483238695077',
    projectId: 'meky-market',
    storageBucket: 'meky-market.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-DTZNR2xgFVzpOJ26n-fUw84pTj45pMY',
    appId: '1:483238695077:ios:c55319355e747986da7d4c',
    messagingSenderId: '483238695077',
    projectId: 'meky-market',
    storageBucket: 'meky-market.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-DTZNR2xgFVzpOJ26n-fUw84pTj45pMY',
    appId: '1:483238695077:macos:c55319355e747986da7d4c',
    messagingSenderId: '483238695077',
    projectId: 'meky-market',
    storageBucket: 'meky-market.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-DTZNR2xgFVzpOJ26n-fUw84pTj45pMY',
    appId: '1:483238695077:windows:c55319355e747986da7d4c',
    messagingSenderId: '483238695077',
    projectId: 'meky-market',
    storageBucket: 'meky-market.firebasestorage.app',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyA-DTZNR2xgFVzpOJ26n-fUw84pTj45pMY',
    appId: '1:483238695077:linux:c55319355e747986da7d4c',
    messagingSenderId: '483238695077',
    projectId: 'meky-market',
    storageBucket: 'meky-market.firebasestorage.app',
  );
}

const bool kIsWeb = bool.fromEnvironment('dart.vm.product');
