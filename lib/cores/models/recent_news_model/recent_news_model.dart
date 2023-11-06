import 'dart:typed_data';

class RecentNewsModel {
  Uint8List? image;
  String? title;

  RecentNewsModel();

  RecentNewsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }
}
