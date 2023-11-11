import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_states.dart';

import '../../../../../constants.dart';
import '../../../../../cores/utils/app_fcm_actions.dart';
import '../../../../../cores/utils/locator_manger.dart';
import '../main_screen_cubit/main_screen_cubit.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenStates> {
  ProfileScreenCubit() : super(InitProfileScreenState());

  static ProfileScreenCubit get(context) => BlocProvider.of(context);

  String? userName;
  String? imageUrl;

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

  Future<void> sendFollowDataToFireStore(String id) async {
    emit(LoadingSendFollowToFireStoreState());

    _sendFollowerToFireStore(id).then((value) {
      _sendFollowingToFireStore(id);
      emit(SuccessSendFollowToFireStoreState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> _sendFollowerToFireStore(String id) async {
    FireStoreServices.fireStore
        .collection('users')
        .doc(id)
        .collection('followers')
        .doc(uId)
        .set({
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

  Future<void> _sendFollowingToFireStore(String id) async {
    await FireStoreServices.fireStore
        .collection('users')
        .doc(uId)
        .collection('following')
        .doc(id)
        .set({
      'displayName': userName,
      'imageUrl': imageUrl,
    });

    AppFcmActions.sendFollowNotification(id);
  }
}
