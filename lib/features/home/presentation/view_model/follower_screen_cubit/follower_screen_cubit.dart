import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/follower_model/follower_model.dart';
import 'follower_screen_states.dart';

class FollowerScreenCubit extends Cubit<FollowerScreenStates> {
  FollowerScreenCubit() : super(InitFollowerScreenStates());

  List<FollowerModel> followers = [];
  bool finishGetFollowers = false;

  static FollowerScreenCubit get(context) => BlocProvider.of(context);

  Future<void> getScreenFollowers(String id) async {
    emit(LoadingToGetFollowersScreenState());

    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(id)
          .collection('followers')
          .get();

      for (var element in data.docs) {
        followers.add(FollowerModel.fromJson(element.data()));
      }
      finishGetFollowers = true;
      emit(SuccessToGetFollowersScreenState());
    } catch (e) {
      print(e);
      finishGetFollowers = true;
      emit(FailureToGetFollowersScreenState(e.toString()));
    }
  }
}
