import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/authentication/presentation/view_model/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());

  String name = '';
  String phone = '';
  String emailAddress = '';
  String accountPassword = '';

  static RegisterCubit get(context) => BlocProvider.of(context);

  set setName(String value) {
    name = value;
  }

  set setPassword(String value) {
    accountPassword = value;
  }

  set setEmailAddress(String value) {
    emailAddress = value;
  }

  set setPhoneNumber(String value) {
    phone = value;
  }

  Future<void> createNewAnonymousUser() async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: accountPassword,
      );

      print(credential.user?.email);
      emit(RegisterSuccessState());
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

      emit(RegisterFailureState(e.code));
    }
  }
}
