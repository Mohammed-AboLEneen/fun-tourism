abstract class AppMainScreenStates {}

class AppMainScreenInitState extends AppMainScreenStates {}

class GetUserDataLoadingState extends AppMainScreenStates {}

class GetUserDataSuccessState extends AppMainScreenStates {}

class GetUserDataFailureState extends AppMainScreenStates {
  String message;

  GetUserDataFailureState(this.message);
}

class ChangeBottomNavigationBarIndex extends AppMainScreenStates {}
