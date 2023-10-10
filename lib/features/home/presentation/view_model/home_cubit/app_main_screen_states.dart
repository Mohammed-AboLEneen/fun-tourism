abstract class AppMainScreenStates {}

class AppMainScreenInitState extends AppMainScreenStates {}

class GetUserDataLoadingState extends AppMainScreenStates {}

class GetUserDataSuccessState extends AppMainScreenStates {}

class GetUserDataFailureState extends AppMainScreenStates {
  String message;

  GetUserDataFailureState(this.message);
}

class GetHomeScreenDataLoadingState extends AppMainScreenStates {}

class GetHomeScreenDataSuccessState extends AppMainScreenStates {}

class GetHomeScreenDataFailureState extends AppMainScreenStates {
  String message;

  GetHomeScreenDataFailureState(this.message);
}

class ChangeBottomNavigationBarIndex extends AppMainScreenStates {}

class GetLocalAppDataSuccessState extends AppMainScreenStates {}

class GetLocalAppDataFailureState extends AppMainScreenStates {}
