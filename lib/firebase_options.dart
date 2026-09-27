import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-DTZNR2xgFVzpOJ26n-fUw84pTj45pMY',
    appId: '1:483238695077:android:c55319355e747986da7d4c',
    messagingSenderId: '483238695077',
    projectId: 'meky-market',
    storageBucket: 'meky-market.firebasestorage.app',
  );
}
