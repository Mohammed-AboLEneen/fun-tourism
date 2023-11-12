import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_firestore_manager.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_states.dart';

import '../../../../../cores/utils/locator_manger.dart';
import '../main_screen_cubit/main_screen_cubit.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenStates> {
  ProfileScreenCubit() : super(InitProfileScreenState());

  static ProfileScreenCubit get(context) => BlocProvider.of(context);

  String userName = '';
  String imageUrl = '';
  String followButtonText = 'follow';
  Color followButtonColor = Colors.indigo;

  Future<void> getUserData(String id) async {
    emit(LoadingGetProfileScreenDataState());

    try {
      await getUserDisplayNameAndImageUrl(id);

      emit(SuccessGetProfileScreenDataState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(FailureGetProfileScreenDataState());
    }
  }

  Future<void> getUserDisplayNameAndImageUrl(String id) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await FireStoreServices.fireStore.collection('users').doc(id).get();

    userName = data.data()?['displayName'];
    imageUrl = data.data()?['photoURL'];
  }

  Future<void> initFollowButtonTextAndColor(String id) async {
    bool result =
        await ProfileScreenFireStore.checkIfCurrentUserFollowThisProfile(id);

    if (result) {
      followButtonText = 'unFollow';
      followButtonColor = Colors.grey;
    } else {
      followButtonText = 'follow';
      followButtonColor = Colors.indigo;
    }

    emit(InitFollowButtonTextAndColorState());
  }

  void chooseTheFollowButtonAction(String id) {
    if (LocatorManager.locator<AppMainScreenCubit>()
            .internetConnection
            .connectionStatus
            .name !=
        'none') {
      if (followButtonText == 'unFollow') {
        removeFollowDataFromFireStore(id);
      } else {
        sendFollowDataToFireStore(id);
      }
    } else {
      showToast(msg: 'No Internet Connection', isFailure: true);
    }
  }

  Future<void> sendFollowDataToFireStore(String id) async {
    followButtonText = '. . .';
    followButtonColor = Colors.cyan.withLightness(.7);
    emit(LoadingSendFollowToFireStoreState());
    ProfileScreenFireStore.sendFollowerToFireStore(id).then((value) {
      ProfileScreenFireStore.sendFollowingToFireStore(id, userName, imageUrl);
      followButtonText = 'unFollow';
      followButtonColor = Colors.grey;

      showToast(msg: 'Follow', isFailure: false);
      emit(SuccessSendFollowToFireStoreState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
        followButtonText = 'Follow';
        followButtonColor = Colors.indigo;
        showToast(msg: 'Fail to Follow, Try Again', isFailure: true);
        emit(FailureSendFollowToFireStoreState());
      }
    });
  }

  Future<void> removeFollowDataFromFireStore(String id) async {
    followButtonText = '. . .';
    followButtonColor = Colors.cyan.withLightness(.7);
    emit(LoadingRemoveFollowToFireStoreState());
    ProfileScreenFireStore.removeFollowerFromOtherUserFireStore(id)
        .then((value) {
      ProfileScreenFireStore.removeFollowedFromCurrentUserFireStore(
        id,
      );
      followButtonText = 'Follow';
      followButtonColor = Colors.indigo;
      showToast(msg: 'unFollow', isFailure: false);
      emit(SuccessRemoveFollowToFireStoreState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
        followButtonText = 'unFollow';
        followButtonColor = Colors.grey;
        showToast(msg: 'Fail to unFollow, Try Again', isFailure: true);
        emit(FailureRemoveFollowToFireStoreState());
      }
    });
  }
}
