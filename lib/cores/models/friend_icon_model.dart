class FriendIconModel {


  String? name;
  String? imageUrl;
  String? uId;

  FriendIconModel();

  FriendIconModel.fromJson(Map<String, dynamic> json, String id){
    name = json['name'];
    imageUrl = json['imageUrl'];
    uId = id;
  }
}