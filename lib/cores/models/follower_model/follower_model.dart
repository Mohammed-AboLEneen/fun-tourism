class FollowerModel {
  String? followerName;
  String? imageUrl;
  int? travelsNumber;
  int? followersNumber;

  FollowerModel();

  FollowerModel.fromJson(Map<String, dynamic> json) {
    followerName = json['displayName'];
    imageUrl = json['imageUrl'];
    travelsNumber = json['travelsNumber'];
    followersNumber = json['followersNumber'];
  }
}
