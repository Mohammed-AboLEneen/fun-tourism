abstract class HomeScreenStates {}

class HomeScreenInitState extends HomeScreenStates {}

class GetUserDataLoadingState extends HomeScreenStates {}

class GetUserDataSuccessState extends HomeScreenStates {}

class GetUserDataFailureState extends HomeScreenStates {
  String message;

  GetUserDataFailureState(this.message);
}

class GetHomeScreenDataLoadingState extends HomeScreenStates {}

class GetHomeScreenDataSuccessState extends HomeScreenStates {}

class GetHomeScreenDataFailureState extends HomeScreenStates {
  String message;

  GetHomeScreenDataFailureState(this.message);
}

class ChangeBottomNavigationBarIndex extends HomeScreenStates {}

class GetLocalAppDataSuccessState extends HomeScreenStates {}

class GetLocalAppDataFailureState extends HomeScreenStates {}

class GetTheUserLocationName extends HomeScreenStates {}
