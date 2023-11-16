class TravelBriefModel {
  String? description;
  String? price;
  String? availablePlaces;
  String? title;
  String? image;

  TravelBriefModel();

  TravelBriefModel.fromJson(Map<String, dynamic> json) {
    description = json["description"];
    price = json["price"];
    availablePlaces = json["availablePlaces"];
    title = json["title"];
  }
}
