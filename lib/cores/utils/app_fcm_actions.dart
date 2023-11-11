import 'package:fun_adventure/cores/utils/env/env.dart';
import 'package:fun_adventure/cores/utils/fcm_sender.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

class AppFcmActions {
  static Future<void> sendFollowNotification(String receiverId) async {
    String topic = '/topics/user_';
    FirebaseFcmSender.sendFCMMessage(
        EnvClass.authorizationKey,
        '$topic$receiverId',
        'New Follower',
        LocatorManager.locator<AppMainScreenCubit>()
                .userData
                ?.userInfoData
                .displayName ??
            '');
  }
}
