import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../../../constants.dart';
import '../../../../../../../../cores/utils/app_fcm_actions.dart';
import '../../../../../../../../cores/utils/firestore_service.dart';
import '../../../../../../../../cores/utils/locator_manger.dart';
import '../../../../../view_model/main_screen_cubit/main_screen_cubit.dart';

class ProfileScreenFireStore {
  static CollectionReference reference =
      FirebaseFirestore.instance.collection('users');

  static Future<void> sendFollowerToFireStore(String id) async {
    reference.doc(id).collection('followers').doc(uId).set({
      'displayName': LocatorManager.locator<AppMainScreenCubit>()
          .userData
          ?.userInfoData
          .displayName,
      'imageUrl': LocatorManager.locator<AppMainScreenCubit>()
          .userData
          ?.userInfoData
          .photoURL,
    });
  }

  static Future<void> sendFollowingToFireStore(
      String id, String userName, String imageUrl) async {
    await reference.doc(uId).collection('following').doc(id).set({
      'displayName': userName,
      'imageUrl': imageUrl,
    });

    AppFcmActions.sendFollowNotification(id);
  }

  static Future<void> removeFollowerFromOtherUserFireStore(String id) async {
    await reference.doc(id).collection('followers').doc(uId).delete();
  }

  static Future<void> removeFollowedFromCurrentUserFireStore(String id) async {
    await reference.doc(uId).collection('following').doc(id).delete();
  }

  static Future<bool> checkIfCurrentUserFollowThisProfile(
      String profileUId) async {
    var doc = await FireStoreServices.fireStore
        .collection('users')
        .doc(uId)
        .collection('following')
        .doc(profileUId)
        .get();

    return doc.exists;
  }

  static Future<bool> checkIfThisProfileFollowCurrentUser(
      String profileUId) async {
    var doc = await FireStoreServices.fireStore
        .collection('users')
        .doc(profileUId)
        .collection('following')
        .doc(uId)
        .get();

    return doc.exists;
  }

  static Future<QuerySnapshot> getProfileFollowerFromFireStore(
      String profileUId) async {
    QuerySnapshot doc = await FireStoreServices.fireStore
        .collection('users')
        .doc(profileUId)
        .collection('followers')
        .get();

    return doc;
  }
}
