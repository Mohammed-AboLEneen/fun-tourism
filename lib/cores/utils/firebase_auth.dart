import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../methods/google_auth.dart';

class FirebaseAuthentication {
  static Future<UserCredential> createOrSignInWithGoogle() async {
    final credential = await googleAuth();

    if (kDebugMode) {
      print(credential.secret);
    }
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> linkGoogleAccountWithFirebaseAccount() async {}

  static Future<void> anonymousSignIn(
      {required String emailAddress, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<bool> createNewAnonymousUser(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user == null ? false : true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }

      return false;
    }
  }
}
