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

class GetLocalAppDataSuccessState extends HomeScreenStates {}

class GetLocalAppDataFailureState extends HomeScreenStates {}

class SuccessGetUserNotificationsState extends HomeScreenStates {}

class LoadingGetUserNotificationsState extends HomeScreenStates {}

class FailureGetUserNotificationsState extends HomeScreenStates {}

class GetTheUserLocationName extends HomeScreenStates {}

class OpenNotificationsScreenState extends HomeScreenStates {}

class CloseNotificationsScreenState extends HomeScreenStates {}

class ChangeNotificationScreenBodyVisibilityState extends HomeScreenStates {}

class ChangeTheCurrentHomeScreenPage extends HomeScreenStates {}
