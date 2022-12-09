// To parse this JSON data, do
//
//     final iosProductData = iosProductDataFromJson(jsonString);

import 'dart:convert';

IosProductData iosProductDataFromJson(String str) => IosProductData.fromJson(json.decode(str));

String iosProductDataToJson(IosProductData data) => json.encode(data.toJson());

class IosProductData {
  IosProductData({
    required this.productId,
    required this.price,
    required this.itemPrice,
  });

  String productId;
  double price;
  double itemPrice;

  factory IosProductData.fromJson(Map<String, dynamic> json) => IosProductData(
    productId: json["productId"],
    price: json["price"].toDouble(),
    itemPrice: json["itemPrice"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "price": price,
    "itemPrice": itemPrice,
  };
}
