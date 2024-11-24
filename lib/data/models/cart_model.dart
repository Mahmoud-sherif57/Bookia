import 'item_model.dart';

class CartModel {
  List<ItemModel>? items;
  String? subTotal;
  String? tax;
  String? shipping;
  String? discount;
  String? total;

  CartModel.formJson(Map<String, dynamic> json) {
    items = (json['items'] as List).map((item) => ItemModel.fromJson(item)).toList();
    subTotal = json["sub_total"];
    tax = json["tax"];
    shipping = json["shipping"];
    discount = json["discount"];
    total = json["total"];
  }
}
