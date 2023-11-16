import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/home/presentation/view_model/add_travel_cubit/add_travel_states.dart';

import '../../../../../constants.dart';
import '../../../../../cores/utils/locator_manger.dart';
import '../main_screen_cubit/main_screen_cubit.dart';

class AddTravelCubit extends Cubit<AddTravelStates> {
  AddTravelCubit() : super(InitialAddTravelState());

  Future<void> addTravel({
    required String travelName,
    required String location,
    required String fromDate,
    required String toDate,
    required String duration,
    required String price,
    required String description,
  }) async {
    if (LocatorManager.locator<AppMainScreenCubit>()
            .internetConnection
            .connectionStatus
            .name !=
        'none') {
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
    return await FirebaseFirestore.instance.collection('travels').add({
      'title': travelName,
      'location': location,
      'fromDate': fromDate,
      'toDate': toDate,
      'time': duration,
      'price': price,
      'description': description,
      'creator': LocatorManager.locator<AppMainScreenCubit>()
          .userData
          ?.userInfoData
          .displayName
    });
  }

  Future<void> _addTravelToCollectionUserTravels({
    required String travelId,
    required String travelName,
    required String price,
    required String description,
  }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('travels')
        .add({
      'title': travelName,
      'price': price,
      'description': description,
      'id': travelId
    });
  }
}
