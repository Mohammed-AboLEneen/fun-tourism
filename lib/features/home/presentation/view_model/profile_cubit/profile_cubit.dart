import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_states.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenStates> {
  ProfileScreenCubit() : super(InitProfileScreenState());

  static ProfileScreenCubit get(context) => BlocProvider.of(context);

  String? userName;
  String? imageUrl;

  Future<void> getUserData(String id) async {
    emit(LoadingProfileScreenState());

    try {
      await getUserDisplayNameAndImageUrl(id);
      emit(SuccessProfileScreenState());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      emit(FailureProfileScreenState());
    }
  }

  Future<void> getUserDisplayNameAndImageUrl(String id) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await FireStoreServices.fireStore.collection('users').doc(id).get();
    userName = data.data()?['displayName'];
    print(userName);
    imageUrl = data.data()?['photoURL'];
    print(imageUrl);
  }
}
