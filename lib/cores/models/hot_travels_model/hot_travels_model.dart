import 'package:fun_adventure/cores/models/hot_travels_model/travel_brief_model.dart';

class HotTravelModel {
  TravelBriefModel? travelBriefModel;
  String? location;
  String? rating;
  String? time;
  String? fromDate;
  String? toDate;
  String? creator;

  HotTravelModel();

  HotTravelModel.fromJson(Map<String, dynamic> json) {
    travelBriefModel = TravelBriefModel.fromJson(json['brief']);
    rating = json['rating'];
    time = json['time'];
    creator = json['creator'];
    location = json['location'];
  }

// Map<String, dynamic> toMap() {
//   Map<String, dynamic> travel = {
//     'title': title,
//     'description': description,
//     'price': price,
//     'rating': rating,
//     'time': time,
//     'creator': creator,
//     'image': image,
//     'location': location,
//     'places': availablePlaces,
//   };
//
//   return travel;
// }
}
