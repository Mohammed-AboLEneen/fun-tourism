abstract class ChatContentStates {}

class InitChatContentState extends ChatContentStates {}

class LoadingToGetLocalChatMessagesState extends ChatContentStates {}

class SuccessGetLocalChatMessagesState extends ChatContentStates {}

class FailureGetLocalChatMessagesState extends ChatContentStates {
  final String error;

  FailureGetLocalChatMessagesState(this.error);
}

class LoadingSaveNewChatMessageState extends ChatContentStates {}

class SuccessSaveNewChatMessageState extends ChatContentStates {}

class FailureSaveNewChatMessageState extends ChatContentStates {
  final String error;

  FailureSaveNewChatMessageState(this.error);
}

class SavedNewChatMessageState extends ChatContentStates {}

class StartSavingNewMessagesState extends ChatContentStates {}

class FinishSavingNewMessagesState extends ChatContentStates {}
