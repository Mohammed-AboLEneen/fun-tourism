import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/internet_connection.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_firestore_manager.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_states.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants.dart';
import '../../../../../cores/utils/locator_manger.dart';
import '../../../data/models/follower_icon_model/follower_icon_model.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenStates> {
  ProfileScreenCubit() : super(InitProfileScreenState());

  static ProfileScreenCubit get(context) => BlocProvider.of(context);

  UserInfoData? userInfoData;
  String followButtonText = 'follow';
  Color followButtonColor = Colors.indigo;
  bool isFollowU = false;
  List<FollowerIconModel> followers = [];

  Future<void> profileCubitOperations(String id) async {
    await initFollowButtonTextAndColor(id);
    await checkIfThisProfileFollowCurrentUser(id);
    await getProfileFollowers(id);
    await getUserData(id);
  }

  Future<void> getUserData(String id) async {
    emit(LoadingGetProfileScreenDataState());

    try {
      DocumentSnapshot<Map<String, dynamic>> data =
      await FirebaseFirestore.instance.collection('users').doc(id).get();

      userInfoData = UserInfoData.fromJson(data.data() as Map<String, dynamic>);

      emit(SuccessGetProfileScreenDataState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(FailureGetProfileScreenDataState());
    }
  }

  Future<void> getProfileFollowers(String id) async {
    QuerySnapshot docs =
    await ProfileScreenFireStore.getProfileFollowerFromFireStore(id);

    for (var element in docs.docs) {
      followers.add(FollowerIconModel.fromJson(
          element.data() as Map<String, dynamic>, element.id));
    }

    emit(InitFollowButtonTextAndColorState());
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

  void chooseTheFollowButtonAction({required String id,
    required String userName,
    required String imageUrl}) {
    if (LocatorManager
        .locator<InternetConnectionState>()
        .connectionStatus
        .name !=
        'none') {
      if (followButtonText == 'unFollow') {
        removeFollowDataFromFireStore(id);
      } else {
        sendFollowDataToFireStore(
            id: id, userName: userName, imageUrl: imageUrl);
      }
    } else {
      showToast(
          msg: 'No Internet Connection',
          toastMessageType: ToastMessageType.failureMessage);
    }
  }

  Future<void> sendFollowDataToFireStore({required String id,
    required String userName,
    required String imageUrl}) async {
    followButtonText = '. . .';
    followButtonColor = Colors.cyan.withLightness(.7);
    emit(LoadingSendFollowToFireStoreState());
    int? travelsNumber = await ProfileScreenFireStore.getCurrentUserDataNumber(
        id: id, collectionName: 'travels');
    int? followersNumber = await ProfileScreenFireStore
        .getCurrentUserDataNumber(
        id: id, collectionName: 'followers');
    ProfileScreenFireStore.sendFollowerToFireStore(
        id: id,
        travelsNumber: travelsNumber!,
        followersNumber: followersNumber!)
        .then((value) async {
      ProfileScreenFireStore.sendFollowingToFireStore(
        id: id,
        userName: userName,
        imageUrl: imageUrl,
      );
      followButtonText = 'unFollow';
      followButtonColor = Colors.grey;

      showToast(
          msg: 'Follow', toastMessageType: ToastMessageType.successMessage);
      emit(SuccessSendFollowToFireStoreState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
        followButtonText = 'Follow';
        followButtonColor = Colors.indigo;
        showToast(
            msg: 'Fail to Follow, Try Again',
            toastMessageType: ToastMessageType.failureMessage);
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
      showToast(
          msg: 'unFollow', toastMessageType: ToastMessageType.successMessage);
      emit(SuccessRemoveFollowToFireStoreState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
        followButtonText = 'unFollow';
        followButtonColor = Colors.grey;
        showToast(
            msg: 'Fail to unFollow, Try Again',
            toastMessageType: ToastMessageType.failureMessage);
        emit(FailureRemoveFollowToFireStoreState());
      }
    });
  }

  Future<void> checkIfThisProfileFollowCurrentUser(String id) async {
    isFollowU =
    await ProfileScreenFireStore.checkIfThisProfileFollowCurrentUser(id);
    emit(CheckIfThisProfileFollowCurrentUser());
  }

  late File _image;
  final picker = ImagePicker();

  Future updateProfileImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);

      if (!context.mounted) return;
      uploadImageToFirebaseStorage(context);
    } else {
      showToast(
          msg: 'Canceled', toastMessageType: ToastMessageType.failureMessage);
    }
  }

  int imageUploadProgress = 0;
  bool startUploadImage = false;

  Future uploadImageToFirebaseStorage(BuildContext context) async {
    startUploadImage = true;
    emit(LoadingUpdateProfileImageState());
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("users/$uId/userImage");
    UploadTask uploadTask = ref.putFile(_image);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      imageUploadProgress = progress.round();
      emit(UpdateImageUploadProgressValueState());
      if (kDebugMode) {
        print("Upload is $imageUploadProgress% complete");
      }
    });

    await uploadTask.whenComplete(() async {
      userInfoData?.photoURL = await ref.getDownloadURL();
      imageUploadProgress = 0;
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .update({'photoURL': userInfoData?.photoURL}).then((value) {
        BlocProvider.of<AppMainScreenCubit>(context)
            .changePhotoURLValue(userInfoData?.photoURL ?? '');
        showToast(
            msg: 'Successfully Updated Profile Image',
            toastMessageType: ToastMessageType.successMessage);
        emit(SuccessUpdateProfileImageState());
        startUploadImage = false;
      });
    }).catchError((error) {
      startUploadImage = false;
      emit(FailureUpdateProfileImageState());
    });
  }
}
