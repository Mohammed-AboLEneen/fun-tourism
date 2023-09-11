import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/authentication/presentation/view_model/login_cubit/login_states.dart';

import '../../../../../cores/methods/google_auth.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  String emailAddress = '';
  String accountPassword = '';

  void putEmailAddress(String email) {
    emailAddress = email;
  }

  void putPassword(String password) {
    accountPassword = password;
  }

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<UserCredential?> createOrSignInWithGoogle() async {
    UserCredential? userCredential;
    try {
      final credential = await googleAuth();
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(e.toString()));
    }
    return userCredential;
  }

  Future<void> anonymousSignIn(
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

  Future<bool> createNewAnonymousUser(
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
