import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'recent_news_model.g.dart';

@HiveType(typeId: 3)
class RecentNewsModel {
  @HiveField(0)
  Uint8List? image;
  @HiveField(1)
  String? title;

  RecentNewsModel();

  RecentNewsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }
}
