import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/authentication/presentation/view_model/login_cubit/login_states.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../cores/errors/sign_up_error.dart';
import '../../../../../cores/methods/google_auth.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  String emailAddress = '';
  String accountPassword = '';

  set putEmailAddress(String email) {
    emailAddress = email;
  }

  set putPassword(String password) {
    accountPassword = password;
  }

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<UserCredential?> createOrSignInWithGoogle() async {
    UserCredential? userCredential;

    emit(LoginLoadingState());
    try {
      // Create a new credential
      final credential = await googleAuth();

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      emit(LoginSuccessState(authResult.user?.providerData[0]));
    } catch (e) {
      emit(LoginFailureState(SignupEmailPassFailure(e.toString()).message));
    }

    return userCredential;
  }

  Future<void> anonymousSignIn() async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: accountPassword,
      );

      emit(LoginSuccessState(credential.user));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      emit(LoginFailureState(e.code));
    }
  }
}
