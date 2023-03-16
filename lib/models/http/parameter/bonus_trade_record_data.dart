// To parse this JSON data, do
//
//     final bonusTradeRecordData = bonusTradeRecordDataFromJson(jsonString);

import 'dart:convert';

BonusTradeRecordData bonusTradeRecordDataFromJson(String str) =>
    BonusTradeRecordData.fromJson(json.decode(str));

String bonusTradeRecordDataToJson(BonusTradeRecordData data) =>
    json.encode(data.toJson());

class BonusTradeRecordData {
  BonusTradeRecordData({
    required this.itemName,
    required this.createdAt,
    required this.imgUrl,
    required this.orderNo,
    required this.tradeSavingsRate,
    required this.income,
    required this.price,
  });

  String itemName;
  DateTime createdAt;
  String imgUrl;
  String orderNo;
  num tradeSavingsRate;
  num income;
  num price;

  factory BonusTradeRecordData.fromJson(Map<String, dynamic> json) =>
      BonusTradeRecordData(
        itemName: json["itemName"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        imgUrl: json["imgUrl"] ?? '',
        orderNo: json["orderNo"] ?? '',
        tradeSavingsRate: json["tradeSavingsRate"] ?? 0,
        income: json["income"] ?? 0,
        price: json["price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "createdAt": createdAt.toIso8601String(),
        "imgUrl": imgUrl,
        "orderNo": orderNo,
        "tradeSavingsRate": tradeSavingsRate,
        "income": income,
        "price": price,
      };
}
