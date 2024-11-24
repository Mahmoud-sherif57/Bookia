class OrdersModel {
  num? id;
  num? userId;
  num? couponId;
  String? subTotal;
  String? tax;
  String? shopping;
  String? discount;
  String? total;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? lat;
  String? lng;
  num? paymentType;
  num? transactionId;
  num? status;
  String? createdAt;
  String? updatedAt;

  OrdersModel({
    required this.id,
    required this.userId,
    required this.couponId,
    required this.subTotal,
    required this.tax,
    required this.shopping,
    required this.discount,
    required this.total,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.lat,
    required this.lng,
    required this.paymentType,
    required this.transactionId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    couponId = json["coupon_id"];
    subTotal = json["sub_total"];
    tax = json["tax"];
    shopping = json["shipping"];
    discount = json["discount"];
    total = json["total"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    address = json["address"];
    lat = json["lat"];
    lng = json["lng"];
    paymentType = json["payment_type"];
    transactionId = json["transaction_id"];
    status = json["status"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  // "id": 6,
  // "user_id": 6,
  // "coupon_id": null,
  // "sub_total": "407.00",
  // "tax": "61.05",
  // "shipping": "214.00",
  // "discount": "0.00",
  // "total": "682.05",
  // "name": "sexy",
  // "email": "Mekhi.Bahringer@hotmail.com",
  // "phone": "319-702-6341",
  // "address": "Quality Mali Rustic Granite benchmark",
  // "lat": "74.4165",
  // "lng": "-120.2525",
  // "payment_type": 0,
  // "transaction_id": null,
  // "status": 0,
  // "created_at": "2024-11-04T22:20:10.000000Z",
  // "updated_at": "2024-11-04T22:20:10.000000Z"
}
