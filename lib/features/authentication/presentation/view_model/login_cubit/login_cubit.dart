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

    emit(LoginLoadingState());
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

  Future<void> anonymousSignIn() async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: accountPassword,
      );

      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }
}
