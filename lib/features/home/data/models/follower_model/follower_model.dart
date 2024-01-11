class FollowerModel {
  String? followerName;
  String? imageUrl;
  String? uId;
  int? travelsNumber;
  int? followersNumber;

  FollowerModel();

  FollowerModel.fromJson(Map<String, dynamic> json) {
    followerName = json['displayName'];
    imageUrl = json['imageUrl'];
    travelsNumber = json['travelsNumber'];
    followersNumber = json['followersNumber'];
    uId = json['uId'];
  }
}
