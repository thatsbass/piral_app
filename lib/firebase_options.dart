import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Remplace ces valeurs par celles de ta console Firebase
    return const FirebaseOptions(
    apiKey: 'AIzaSyDhAD4o3PJscRPmRzfR5h-SglrVodXc598',
    appId: '1:798156677861:android:36684becfb234532c52a0c',
    messagingSenderId: '798156677861',
    projectId: 'peril-54f0d',
    authDomain: 'peril-54f0d.firebaseapp.com',
    storageBucket: 'peril-54f0d.firebasestorage.app',
    );
  }
}