import 'dart:typed_data';

class HotTravelModel {
  String? description;

  String? price;

  String? availablePlaces;

  String? title;

  Uint8List? image;

  HotTravelModel();

  HotTravelModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    price = json['price'];
    availablePlaces = json['places'];
    title = json['title'];
    image = json['image'];
  }
}
