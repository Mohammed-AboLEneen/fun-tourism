import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/home_states.dart';

class HomePageCubit extends Cubit<HomePageStates> {

  HomePageCubit() : super(HomePageInitState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  Future<void> getUserData(String email) async {
    emit(HomePageLoadingState());
    try {
      DocumentSnapshot<Object?> userData = await FireStoreServices.getUserData(
          email: email);

      emit(HomePageSuccessState());
    } catch (e) {
      emit(HomePageFailureState());
    }
  }
}