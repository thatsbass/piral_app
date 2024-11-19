import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }


Future<void> registerWithEmail(
  String email,
  String password,
  String firstName,
  String lastName,
  String address,
  String cin,
  String phone,
) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .set({
        'nom': lastName,
        'prenom': firstName,
        'adresse': address,
        'CIN': cin,
        'telephone': phone,
        'email': email,
        'role': 'client',
        'account': {
          'balance': 0,
          'balanceMax': 1000000,
          'balanceMensuel': 20000,
          'status': 'ACTIVE',
          'qrcode': 'qrcodetoBase64',
        },
      });

      Get.snackbar('Succès', 'Compte créé et ajouté à Firestore avec succès');
    }
  } catch (e) {
    Get.snackbar('Erreur', e.toString());
  }
}

  Future<void> loginWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Succès', 'Connexion réussie');
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    }
  }

  // Authentification Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.snackbar('Succès', 'Connexion Google réussie');
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    }
  }

  // Authentification par téléphone
  Future<void> verifyPhone(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('Erreur', e.message ?? 'Erreur de vérification');
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.toNamed('/verify-code', arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyCode(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      Get.snackbar('Succès', 'Vérification réussie');
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}