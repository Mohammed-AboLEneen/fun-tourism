import 'package:hive/hive.dart';

part 'hot_travels_model.g.dart';

@HiveType(typeId: 2)
class HotTravelModel {
  @HiveField(0)
  String? description;
  @HiveField(1)
  String? price;
  @HiveField(2)
  String? availablePlaces;

  HotTravelModel();

  HotTravelModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    price = json['price'];
    availablePlaces = json['places'];
  }
}
