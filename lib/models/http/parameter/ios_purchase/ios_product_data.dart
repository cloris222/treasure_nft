// To parse this JSON data, do
//
//     final iosProductData = iosProductDataFromJson(jsonString);

import 'dart:convert';

IosProductData iosProductDataFromJson(String str) =>
    IosProductData.fromJson(json.decode(str));

String iosProductDataToJson(IosProductData data) => json.encode(data.toJson());

class IosProductData {
  IosProductData({
    required this.productId,
    required this.price,
    required this.itemPrice,
    required this.weeklyPurchaseLimit,
    required this.quantityPurchasedThisWeek,
    required this.isReachedPurchaseLimit,
  });

  String productId;
  num price;
  num itemPrice;

  ///每周限購
  num weeklyPurchaseLimit;

  ///本週購買數量
  num quantityPurchasedThisWeek;

  ///是否達到購買上限
  bool isReachedPurchaseLimit;

  factory IosProductData.fromJson(Map<String, dynamic> json) => IosProductData(
        productId: json["productId"],
        price: json["price"] ?? 0,
        itemPrice: json["itemPrice"] ?? 0,
        weeklyPurchaseLimit: json["weeklyPurchaseLimit"] ?? 0,
        quantityPurchasedThisWeek: json["quantityPurchasedThisWeek"] ?? 0,
        isReachedPurchaseLimit: json["isReachedPurchaseLimit"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "price": price,
        "itemPrice": itemPrice,
        "weeklyPurchaseLimit": weeklyPurchaseLimit,
        "quantityPurchasedThisWeek": quantityPurchasedThisWeek,
        "isReachedPurchaseLimit": isReachedPurchaseLimit,
      };
}
