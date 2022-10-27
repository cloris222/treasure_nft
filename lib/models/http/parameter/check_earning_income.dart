// To parse this JSON data, do
//
//     final checkEarningIncomeInfo = checkEarningIncomeInfoFromJson(jsonString);

import 'dart:convert';

CheckEarningIncomeData checkEarningIncomeInfoFromJson(String str) =>
    CheckEarningIncomeData.fromJson(json.decode(str));

String checkEarningIncomeInfoToJson(CheckEarningIncomeData data) =>
    json.encode(data.toJson());

class CheckEarningIncomeData {
  CheckEarningIncomeData({
    required this.orderNo,
    required this.time,
    required this.itemId,
    required this.itemName,
    required this.sellerName,
    required this.sellerRelated,
    required this.imgUrl,
    required this.price,
    required this.income,
    required this.rebate,
    required this.originImgUrl,
  });

  String orderNo;
  DateTime time;
  String itemId;
  String itemName;
  String sellerName;
  String sellerRelated;
  String imgUrl;
  double price;
  double income;
  double rebate;
  String originImgUrl;

  factory CheckEarningIncomeData.fromJson(Map<String, dynamic> json) =>
      CheckEarningIncomeData(
        orderNo: json["orderNo"],
        time: DateTime.parse(json["time"]),
        itemId: json["itemId"],
        itemName: json["itemName"],
        sellerName: json["sellerName"],
        sellerRelated: json["sellerRelated"],
        imgUrl: json["imgUrl"],
        price: json["price"].toDouble(),
        income: json["income"].toDouble(),
        rebate: json["rebate"].toDouble(),
        originImgUrl: json["originImgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "orderNo": orderNo,
        "time": time.toIso8601String(),
        "itemId": itemId,
        "itemName": itemName,
        "sellerName": sellerName,
        "sellerRelated": sellerRelated,
        "imgUrl": imgUrl,
        "price": price,
        "income": income,
        "rebate": rebate,
        "originImgUrl": originImgUrl,
      };
}
