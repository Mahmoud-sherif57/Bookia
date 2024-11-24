class SliderModel {
  num? sliderId;
  num? bookId;
  String? image;
  String? title;

  SliderModel({
    required this.sliderId,
    required this.bookId,
    required this.image,
    required this.title,

  });

  SliderModel.fromJson(Map<String,dynamic > json){
    sliderId = json["slider_id"];
    bookId =json["book_id"];
    image =json["image"];
    title =json["title"];
  }
}
