// To parse this JSON data, do
//
//     final iosPurchase = iosPurchaseFromJson(jsonString);

import 'dart:convert';

IosPurchaseData iosPurchaseFromJson(String str) => IosPurchaseData.fromJson(json.decode(str));

String iosPurchaseToJson(IosPurchaseData data) => json.encode(data.toJson());

class IosPurchaseData {
  IosPurchaseData({
    required this.result,
  });

  List<Result> result;

  factory IosPurchaseData.fromJson(Map<String, dynamic> json) => IosPurchaseData(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.orderNo,
    required this.itemId,
    required this.itemName,
    required this.imgUrl,
    required this.price,
  });

  String orderNo;
  String itemId;
  String itemName;
  String imgUrl;
  double price;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    orderNo: json["orderNo"],
    itemId: json["itemId"],
    itemName: json["itemName"],
    imgUrl: json["imgUrl"],
    price: json["price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "orderNo": orderNo,
    "itemId": itemId,
    "itemName": itemName,
    "imgUrl": imgUrl,
    "price": price,
  };
}
