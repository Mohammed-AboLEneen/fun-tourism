import 'package:hive/hive.dart';

part 'recent_news_model.g.dart';

@HiveType(typeId: 3)
class RecentNewsModel {
  @HiveField(0)
  String? image;
  @HiveField(1)
  String? title;

  RecentNewsModel();

  RecentNewsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }
}
