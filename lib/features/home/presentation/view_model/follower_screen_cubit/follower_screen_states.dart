abstract class FollowerScreenStates {}

class InitFollowerScreenStates extends FollowerScreenStates {}

class LoadingToGetFollowersScreenState extends FollowerScreenStates {}

class FailureToGetFollowersScreenState extends FollowerScreenStates {
  final String msg;

  FailureToGetFollowersScreenState(this.msg);
}

class SuccessToGetFollowersScreenState extends FollowerScreenStates {}
