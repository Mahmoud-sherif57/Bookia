class UserInfoModel {
  num? userId;
  String? userName;
  String? userEmail;
  String? image;
  String? address;
  String? lat;
  String? lng;

  UserInfoModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.image,
    required this.address,
    required this.lat,
    required this.lng,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json["id"];
    userName = json["name"];
    userEmail = json["email"];
    image = json["image"];
    address = json["address"];
    lat = json["lat"];
    lng = json["lng"];
  }
}
