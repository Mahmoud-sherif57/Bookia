class BookModel {
  num? bookId;
  num? categoryId;
  String? imageUrl;
  String? bookName;
  String? categoryName;
  String? price;
  String? offer;
  bool? isInTheWishList;

  BookModel({
    required this.categoryId,
    required this.bookId,
    required this.imageUrl,
    required this.bookName,
    required this.categoryName,
    required this.price,
    required this.offer,
    this.isInTheWishList = false,
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    categoryId = json["category_id"];
    bookId = json["book_id"];
    categoryName = json["category_name"];
    bookName = json["name"];
    imageUrl = json["image"];
    price = json["price"];
    offer = json["offer"];
    isInTheWishList = json["is_in_my_wishlist"];
  }
}
