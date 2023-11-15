import 'dart:typed_data';

class HotTravelModel {
  String? description;
  String? price;
  String? availablePlaces;
  String? title;
  String? location;
  String? rating;
  String? time;
  String? fromDate;
  String? toDate;
  String? creator;
  Uint8List? image;

  HotTravelModel() {
    description = '';
    price = '';
    availablePlaces = '';
    title = '';
    location = '';
    rating = '';
    time = '';
    fromDate = '';
    toDate = '';
    creator = '';
    image = Uint8List(0);
  }

  HotTravelModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    price = json['price'];
    availablePlaces = json['places'];
    title = json['title'];
    rating = json['rating'];
    time = json['time'];
    creator = json['creator'];
    image = json['image'];
    location = json['location'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> travel = {
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'time': time,
      'creator': creator,
      'image': image,
      'location': location,
      'places': availablePlaces,
    };

    return travel;
  }
}
