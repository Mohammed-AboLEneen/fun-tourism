import '../../../../../cores/models/user_data_info/user_info_data.dart';

abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  bool? emailVerified;
  bool? isNewUser;
  UserInfoData user;

  RegisterSuccessState(
      {required this.emailVerified,
      required this.isNewUser,
      required this.user});
}

class RegisterFailureState extends RegisterStates {
  final String message;

  RegisterFailureState(this.message);
}
