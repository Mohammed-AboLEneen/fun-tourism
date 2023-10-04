import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  bool emailVerified;
  bool isGoogleAuth;
  bool? isNewUser;
  UserInfoData user;

  LoginSuccessState(
      {required this.emailVerified,
      required this.user,
      required this.isNewUser,
      required this.isGoogleAuth});
}

class LoginFailureState extends LoginStates {
  final String message;

  LoginFailureState(this.message);
}
