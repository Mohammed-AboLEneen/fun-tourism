import 'package:fun_adventure/cores/utils/env/env.dart';
import 'package:fun_adventure/cores/utils/fcm_sender.dart';

class AppFcmActions {
  static Future<void> sendFollowNotification(
      {String? image,
      required String receiverId,
      required String title,
      required String body}) async {
    FirebaseFcmSender.sendFCMMessage(
        EnvClass.authorizationKey, receiverId, title, image: image, body);
  }
}
