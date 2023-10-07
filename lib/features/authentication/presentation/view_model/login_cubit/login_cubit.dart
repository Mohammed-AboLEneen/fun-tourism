import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:fun_adventure/features/authentication/presentation/view_model/login_cubit/login_states.dart';

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

  Future<void> createOrSignInWithGoogle() async {
    UserCredential? userCredential;

    emit(LoginLoadingState());
    try {
      // Create a new credential
      final credential = await googleAuth();

      final UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(LoginSuccessState(
          emailVerified: FirebaseAuth.instance.currentUser!.emailVerified,
          user: UserInfoData.getAnonymousUserData(
            user: authResult.user?.providerData[0],
          ),
          isNewUser: authResult.additionalUserInfo?.isNewUser,
          isGoogleAuth: true));
    } on FirebaseException catch (e) {
      emit(LoginFailureState(e.code));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: accountPassword,
      );

      emit(LoginSuccessState(
          emailVerified: credential.user!.emailVerified,
          user: UserInfoData.getAnonymousUserData(user: credential.user),
          isNewUser: credential.additionalUserInfo?.isNewUser,
          isGoogleAuth: false));
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Failed with error code: ${e.code}');
      }
      emit(LoginFailureState(e.code));
    }
  }
}
