class UserInfoGoogleModel{
  String? displayName ;
  String? email ;
  String? photoUrl ;


  UserInfoGoogleModel({this.displayName, this.email, this.photoUrl}) ;

  UserInfoGoogleModel.fromJson(Map <String? ,dynamic> json){
    displayName = json["displayName"];
    email = json["email"];
    photoUrl = json["photoUrl"];

  }

  Map<String?,dynamic> toJson (){
    final Map <String? ,dynamic> mapData = <String? ,dynamic> {};
    mapData["displayName"] = displayName;
    mapData["email"] = email;
    mapData["photoUrl"] = photoUrl ;

    return mapData;
  }
}