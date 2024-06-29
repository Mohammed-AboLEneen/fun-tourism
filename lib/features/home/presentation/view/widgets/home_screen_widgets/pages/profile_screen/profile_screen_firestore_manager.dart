import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/methods/toast.dart';

import '../../../../../../../../constants.dart';
import '../../../../../../../../cores/utils/app_fcm_actions.dart';
import '../../../../../../../../cores/utils/locator_manger.dart';
import '../../../../../view_model/main_screen_cubit/main_screen_cubit.dart';

class ProfileScreenFireStore {
  static CollectionReference reference =
      FirebaseFirestore.instance.collection('users');

  static Future<void> sendFollowerToFireStore(
      {required String id,
      required int travelsNumber,
      required int followersNumber}) async {
    reference.doc(id).collection('followers').doc(uId).set({
      'displayName': LocatorManager.locator<AppMainScreenCubit>()
          .userData
          ?.userInfoData
          .displayName,
      'imageUrl': LocatorManager.locator<AppMainScreenCubit>()
          .userData
          ?.userInfoData
          .photoURL,
      'travelsNumber': travelsNumber,
      'followersNumber': followersNumber,
      'uId': uId
    });
  }

  // send fcm message to profile which just follow it
  static Future<void> sendFollowingToFireStore({
    required String id,
    required String userName,
    required String imageUrl,
  }) async {
    await reference.doc(uId).collection('following').doc(id).set({
      'followerName': userName,
      'imageUrl': imageUrl,
    });

    if (kDebugMode) {
      print(id);
    }
    AppFcmActions.sendFollowNotification(
        image: LocatorManager.locator<AppMainScreenCubit>()
            .userData
            ?.userInfoData
            .photoURL,
        receiverId: id,
        title: 'New Follower',
        body: LocatorManager.locator<AppMainScreenCubit>()
                .userData
                ?.userInfoData
                .displayName ??
            '');
  }

  static Future<void> removeFollowerFromOtherUserFireStore(String id) async {
    await reference.doc(id).collection('followers').doc(uId).delete();
  }

  static Future<void> removeFollowedFromCurrentUserFireStore(String id) async {
    await reference.doc(uId).collection('following').doc(id).delete();
  }

  static Future<bool> checkIfCurrentUserFollowThisProfile(
      String profileUId) async {
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('following')
        .doc(profileUId)
        .get();

    return doc.exists;
  }

  static Future<bool> checkIfThisProfileFollowCurrentUser(
      String profileUId) async {
    var doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(profileUId)
        .collection('following')
        .doc(uId)
        .get();

    return doc.exists;
  }

  static Future<int?> getCurrentUserDataNumber(
      {required String id, required String collectionName}) async {
    AggregateQuerySnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection(collectionName)
        .count()
        .get();
    return data.count;
  }

  static Future<QuerySnapshot> getProfileFollowerFromFireStore(
      String profileUId) async {
    QuerySnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(profileUId)
        .collection('followers')
        .get();

    return doc;
  }

  static Future<void> updateProfileData(
      {required String name, required String phone, required String id}) async {
    showToast(
        msg: 'Waiting Please',
        toastMessageType: ToastMessageType.waitingMessage,
        textColor: Colors.black);

    try {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'displayName': name,
        'phoneNumber': phone,
      });
      showToast(
          msg: 'Successfully Editing',
          toastMessageType: ToastMessageType.successMessage);
    } catch (e) {
      showToast(
          msg: 'Failed to Edit, Try Again',
          toastMessageType: ToastMessageType.failureMessage);
    }
  }
}
