abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {
  final String message;

  RegisterFailureState(this.message);
}
