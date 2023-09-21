abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final dynamic userInfo;

  LoginSuccessState(this.userInfo);
}

class LoginFailureState extends LoginStates {
  final String message;

  LoginFailureState(this.message);
}
