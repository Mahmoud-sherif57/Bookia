class BaseModel {
  final num id;
  final String imageUrl;
  final String name;
  final String writerName;
  final num price;
  final num review;
  final num star;
  late bool isFavourite;
  late bool isOnTheCart;
  num? value;

  BaseModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.writerName,
    required this.price,
    required this.review,
    required this.star,
    required this.value,
     this.isFavourite =false,
     this.isOnTheCart =false,
  });
}
