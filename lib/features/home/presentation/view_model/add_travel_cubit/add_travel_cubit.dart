import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/home/presentation/view_model/add_travel_cubit/add_travel_states.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants.dart';
import '../../../../../cores/methods/toast.dart';
import '../../../../../cores/utils/internet_connection.dart';
import '../../../../../cores/utils/locator_manger.dart';
import '../main_screen_cubit/main_screen_cubit.dart';

class AddTravelCubit extends Cubit<AddTravelStates> {
  AddTravelCubit() : super(InitialAddTravelState());

  static AddTravelCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> addTravel({
    required String travelName,
    required String location,
    required String fromDate,
    required String toDate,
    required String duration,
    required String price,
    required String description,
  }) async {
    if (LocatorManager.locator<InternetConnectionState>()
            .connectionStatus
            .name !=
        'none') {
      if (image == null) {
        showToast(
            msg: 'Select Travel Image',
            toastMessageType: ToastMessageType.failureMessage);

        return;
      }

      emit(LoadingAddTravelState());
      _addTravelToCollectionTravels(
              travelName: travelName,
              location: location,
              fromDate: fromDate,
              toDate: toDate,
              duration: duration,
              price: price,
              description: description)
          .then((value) {
        _addTravelToCollectionUserTravels(
                travelId: value.id,
                travelName: travelName,
                price: price,
                description: description)
            .then((value) {
          emit(SuccessAddTravelState());
        });
      }).catchError((error) {
        emit(FailureAddTravelState());
      });
    } else {
      emit(ThereIsNoAnInternetState());
    }
  }

  Future<DocumentReference> _addTravelToCollectionTravels({
    required String travelName,
    required String location,
    required String fromDate,
    required String toDate,
    required String duration,
    required String price,
    required String description,
  }) async {
    int travelsCount = await countTravelsNumberInFireStore();

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("travels/$travelsCount}");
    ref.putFile(image!);

    String imageUrl = await ref.getDownloadURL();

    return await FirebaseFirestore.instance.collection('travels').add({
      'title': travelName,
      'location': location,
      'fromDate': fromDate,
      'toDate': toDate,
      'time': duration,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'creator': LocatorManager.locator<AppMainScreenCubit>()
          .userData
          ?.userInfoData
          .displayName
    });
  }

  final picker = ImagePicker();
  File? image;

  Future<void> selectTravelImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);

      emit(SuccessSelectedTravelImageState());
    } else {
      showToast(
          msg: 'Canceled', toastMessageType: ToastMessageType.failureMessage);
      emit(FailureSelectedTravelImageState());
    }
  }

  Future<void> _addTravelToCollectionUserTravels({
    required String travelId,
    required String travelName,
    required String price,
    required String description,
  }) async {
    try {
      int travelsCount = await countTravelsNumberInFireStore();

      FirebaseStorage storage = FirebaseStorage.instance;

      Reference ref = storage.ref().child("travels/$travelsCount}");
      ref.putFile(image!);

      String imageUrl = await ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('travels')
          .add({
        'title': travelName,
        'price': price,
        'description': description,
        'id': travelId,
        'imageUrl': imageUrl
      });
    } catch (e) {
      print(e);
    }
  }

  Future<int> countTravelsNumberInFireStore() async {
    var data =
        await FirebaseFirestore.instance.collection('travels').count().get();
    return data.count;
  }
}
