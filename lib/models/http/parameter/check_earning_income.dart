// To parse this JSON data, do
//
//     final checkEarningIncomeInfo = checkEarningIncomeInfoFromJson(jsonString);

import 'dart:convert';

CheckEarningIncomeData checkEarningIncomeInfoFromJson(String str) =>
    CheckEarningIncomeData.fromJson(json.decode(str));

String checkEarningIncomeInfoToJson(CheckEarningIncomeData data) =>
    json.encode(data.toJson());

class CheckEarningIncomeData {
  CheckEarningIncomeData(
      {required this.orderNo,
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
      required this.saveId,
      required this.saveAmount,
      required this.saveType});

  String orderNo;
  String time;
  String itemId;
  String itemName;
  String sellerName;
  String sellerRelated;
  String imgUrl;
  num price;
  num income;
  num rebate;
  String originImgUrl;

  ///MARK: v0.0.4 增加儲金罐
  String saveId;
  num saveAmount;
  String saveType;

  factory CheckEarningIncomeData.fromJson(Map<String, dynamic> json) =>
      CheckEarningIncomeData(
          orderNo: json["orderNo"] ?? '',
          time: json["time"] ?? '',
          itemId: json["itemId"] ?? '',
          itemName: json["itemName"] ?? '',
          sellerName: json["sellerName"] ?? '',
          sellerRelated: json["sellerRelated"] ?? '',
          imgUrl: json["imgUrl"] ?? '',
          price: json["price"] ?? 0,
          income: json["income"] ?? 0,
          rebate: json["rebate"] ?? 0,
          originImgUrl: json["originImgUrl"] ?? '',
          saveId: json['id'] ?? '',
          saveAmount: json['amount'] ?? 0,
          saveType: json['type'] ?? '');

  Map<String, dynamic> toJson() => {
        "orderNo": orderNo,
        "time": time,
        "itemId": itemId,
        "itemName": itemName,
        "sellerName": sellerName,
        "sellerRelated": sellerRelated,
        "imgUrl": imgUrl,
        "price": price,
        "income": income,
        "rebate": rebate,
        "originImgUrl": originImgUrl,
        "id": saveId,
        "amount": saveAmount,
        "type": saveType,
      };
}
