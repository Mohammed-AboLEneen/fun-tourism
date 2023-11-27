import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/models/message_content_model/message_content_model.dart';
import 'package:fun_adventure/features/home/presentation/view_model/chat_content_cubit/chat_content_states.dart';
import 'package:hive/hive.dart';

import '../../../../../constants.dart';

class ChatContentCubit extends Cubit<ChatContentStates> {
  ChatContentCubit() : super(InitChatContentState());

  static ChatContentCubit get(context) => BlocProvider.of(context);

  List<MessageContentModel> messages = [];
  String chatsBox = 'chat_content';
  late String receiverId;
  bool isGetLocalChat = false;

  late Stream<QuerySnapshot> usersStream;

  void setUserStreamSnapShot(String id) {
    if (isGetLocalChat) {
      usersStream = FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(id)
          .collection('newMessages')
          .orderBy('time', descending: true)
          .snapshots();
    } else {
      usersStream = FirebaseFirestore.instance.collection('null').snapshots();
    }
  }

  Future<void> getLocalChat(String id) async {
    setUserStreamSnapShot(id);
    emit(LoadingToGetLocalChatMessagesState());
    receiverId = id;

    try {
      var box = await Hive.openBox('$receiverId 1111');

      if (box.isNotEmpty) {
        for (MessageContentModel messageContentModel in box.values.toList()) {
          messages.add(messageContentModel);
        }

        messages = messages.reversed.toList();
      }
      isGetLocalChat = true;

      setUserStreamSnapShot(id);
      emit(SuccessGetLocalChatMessagesState());
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      isGetLocalChat = false;
      setUserStreamSnapShot(id);
      emit(FailureGetLocalChatMessagesState(e.toString()));
    }
  }

  bool startSavingMessages = false;

  Future<void> saveTheNewChatMessagesFromFireStore(
      List<QueryDocumentSnapshot<Object?>> docs) async {
    if (docs.isNotEmpty) startSavingMessages = true;

    emit(StartSavingNewMessagesState());
    for (var doc in docs) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      saveChatMessage(MessageContentModel.fromJson(data), doc.id);
    }

    startSavingMessages = false;
    emit(FinishSavingNewMessagesState());
  }

  Future<void> saveChatMessage(
      MessageContentModel messageContentModel, String messageId) async {
    try {
      var box = await Hive.openBox('$receiverId 1111');
      await box.put(messageId, messageContentModel);
      messages.add(messageContentModel);

      print('message is saved');
      emit(SavedNewChatMessageState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
