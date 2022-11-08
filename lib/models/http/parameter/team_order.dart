// To parse this JSON data, do
//
//     final teamOrder = teamOrderFromJson(jsonString);

import 'dart:convert';

TeamOrderData teamOrderFromJson(String str) =>
    TeamOrderData.fromJson(json.decode(str));

String teamOrderToJson(TeamOrderData data) => json.encode(data.toJson());

class TeamOrderData {
  TeamOrderData({
    this.orderNo = '',
    this.type = '',
    this.time,
    this.itemId = '',
    this.itemName = '',
    this.sellerName = '',
    this.buyerAccount = '',
    this.buyerName = '',
    this.imgUrl = '',
    this.price = 0.0,
    this.income = 0.0,
    this.moneyBox = 0.0,
    this.originImgUrl = '',
  });

  String orderNo;
  String type;
  dynamic time;
  String itemId;
  String itemName;
  String sellerName;
  String buyerAccount;
  String buyerName;
  String imgUrl;
  double price;
  double income;
  double moneyBox;
  String originImgUrl;

  factory TeamOrderData.fromJson(Map<String, dynamic> json) => TeamOrderData(
        orderNo: json["orderNo"],
        type: json["type"],
        time: json["time"],
        itemId: json["itemId"],
        itemName: json["itemName"],
        sellerName: json["sellerName"],
        buyerAccount: json["buyerAccount"] ?? '',
        buyerName: json["buyerName"],
        imgUrl: json["imgUrl"],
        price: json["price"]?.toDouble() ?? 0.0,
        income: json["income"]?.toDouble() ?? 0.0,
        moneyBox: json["moneyBox"]?.toDouble() ?? 0.0,
        originImgUrl: json["originImgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "orderNo": orderNo,
        "type": type,
        "time": time.toIso8601String(),
        "itemId": itemId,
        "itemName": itemName,
        "sellerName": sellerName,
        "buyerAccount": buyerAccount,
        "buyerName": buyerName,
        "imgUrl": imgUrl,
        "price": price,
        "income": income,
        "moneyBox": moneyBox,
        "originImgUrl": originImgUrl,
      };

  String getItemName() {
    if (itemName.length > 13) {
      return ('${itemName.substring(0, 5)}...${itemName.substring(itemName.length - 5)}');
    }
    return itemName;
  }
}
