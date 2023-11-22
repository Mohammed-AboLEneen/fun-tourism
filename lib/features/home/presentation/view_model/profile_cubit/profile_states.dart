abstract class ProfileScreenStates {}

class InitProfileScreenState extends ProfileScreenStates {}

class LoadingGetProfileScreenDataState extends ProfileScreenStates {}

class SuccessGetProfileScreenDataState extends ProfileScreenStates {}

class FailureGetProfileScreenDataState extends ProfileScreenStates {}

class LoadingSendFollowToFireStoreState extends ProfileScreenStates {}

class SuccessSendFollowToFireStoreState extends ProfileScreenStates {}

class FailureSendFollowToFireStoreState extends ProfileScreenStates {}

class LoadingRemoveFollowToFireStoreState extends ProfileScreenStates {}

class SuccessRemoveFollowToFireStoreState extends ProfileScreenStates {}

class FailureRemoveFollowToFireStoreState extends ProfileScreenStates {}

class InitFollowButtonTextAndColorState extends ProfileScreenStates {}

class CheckIfThisProfileFollowCurrentUser extends ProfileScreenStates {}

class SuccessUpdateProfileImageState extends ProfileScreenStates {}

class LoadingUpdateProfileImageState extends ProfileScreenStates {}

class FailureUpdateProfileImageState extends ProfileScreenStates {}

class UpdateImageUploadProgressValueState extends ProfileScreenStates {}
