
class ItemModel {
  num? bookId ;
  num? qty ;
  String? image;
  String? price;
  String? offer;
  String? name;

  ItemModel();

  ItemModel.fromJson(Map<String, dynamic > json){
bookId = json["book_id"];
qty = json["qty"];
image = json["image"];
price = json["price"];
offer = json["offer"];
name = json["name"];
  }
}