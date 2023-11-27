import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../constants.dart';

class ChatContentFireStoreHelper {
  static Future<void> sendNewMessage({
    required String id,
    required String message,
  }) async {
    _sendNewMessageForReceiverId(id: id, message: message).then((value) async {
      _sendNewMessageForSenderId(id: id, message: message);
    });
  }

  static Future<void> _sendNewMessageForReceiverId({
    required String id,
    required String message,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('chats')
        .doc(uId)
        .collection('newMessages')
        .add({
      'message': message,
      'time': DateTime.now(),
      'receiverId': id,
      'senderId': uId
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('chats')
          .doc(uId)
          .collection('messages')
          .add({
        'message': message,
        'time': DateTime.now(),
        'receiverId': id,
        'senderId': uId
      });
    });
  }

  static Future<void> _sendNewMessageForSenderId({
    required String id,
    required String message,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(id)
        .collection('messages')
        .add({
      'message': message,
      'time': DateTime.now(),
      'receiverId': id,
      'senderId': uId
    });
  }
}
