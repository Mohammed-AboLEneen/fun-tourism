class FollowerIconModel {
  String? name;
  String? imageUrl;
  String? uId;

  FollowerIconModel();

  FollowerIconModel.fromJson(Map<String, dynamic> json, String id) {
    name = json['displayName'];
    imageUrl = json['imageUrl'];
    uId = id;
  }
}
