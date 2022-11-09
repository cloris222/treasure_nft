// To parse this JSON data, do
//
//     final orderMessageListResponseData = orderMessageListResponseDataFromJson(jsonString);

import 'dart:convert';

OrderMessageListResponseData orderMessageListResponseDataFromJson(String str) => OrderMessageListResponseData.fromJson(json.decode(str));

String orderMessageListResponseDataToJson(OrderMessageListResponseData data) => json.encode(data.toJson());

class OrderMessageListResponseData {
  OrderMessageListResponseData({
    this.orderNo = '',
    this.type = '',
    this.createdAt = '',
    this.itemId = '',
    this.itemName = '',
    this.imgUrl = '',
    this.buyPrice = 0,
    this.seller = '',
    this.payType = '',
    this.sellPrice = 0,
    this.buyer = '',
    this.serviceFee = 0,
    this.royalFee = 0,
    this.income = 0,
    this.price = 0,
    this.status = '',
    this.startPrice = 0,
    this.endPrice = 0,
    this.deposit = 0,
    this.reserveCount = 0,
    this.winCount = 0,
    this.id = '',
    this.time = '',
    this.amount = 0,
    this.originImgUrl = '',
    this.userName = '',
    this.from = '',
    this.to = '',
    this.fee = 0,
  });

  String orderNo;
  String type;
  String createdAt;
  String itemId;
  String itemName;
  String imgUrl;
  num buyPrice;
  String seller;
  String payType;
  num sellPrice;
  String buyer;
  num serviceFee;
  num royalFee;
  num income;
  num price;
  String status;
  num startPrice;
  num endPrice;
  num deposit;
  num reserveCount;
  num winCount;
  String id;
  String time;
  num amount;
  String originImgUrl;
  String userName;
  String from;
  String to;
  num fee;

  factory OrderMessageListResponseData.fromJson(Map<String, dynamic> json) => OrderMessageListResponseData(
    orderNo: json["orderNo"]??'',
    type: json["type"]??'',
    createdAt: json["createdAt"]??'',
    itemId: json["itemId"]??'',
    itemName: json["itemName"]??'',
    imgUrl: json["imgUrl"]??'',
    buyPrice: json["buyPrice"]??0,
    seller: json["seller"]??'',
    payType: json["payType"]??'',
    sellPrice: json["sellPrice"]??0,
    buyer: json["buyer"]??'',
    serviceFee: json["serviceFee"]??0,
    royalFee: json["royalFee"]??0,
    income: json["income"]??0,
    price: json["price"]??0,
    status: json["status"]??'',
    startPrice: json["startPrice"]??0,
    endPrice: json["endPrice"]??0,
    deposit: json["deposit"]??0,
    reserveCount: json["reserveCount"]??0,
    winCount: json["winCount"]??0,
    id: json["id"]??'',
    time: json["time"]??'',
    amount: json["amount"]??0,
    originImgUrl: json["originImgUrl"]??'',
    userName: json["userName"]??'',
    from: json["from"]??'',
    to: json["to"]??'',
    fee: json["fee"]??0,
  );

  Map<String, dynamic> toJson() => {
    "orderNo": orderNo,
    "type": type,
    "createdAt": createdAt,
    "itemId": itemId,
    "itemName": itemName,
    "imgUrl": imgUrl,
    "buyPrice": buyPrice,
    "seller": seller,
    "payType": payType,
    "sellPrice": sellPrice,
    "buyer": buyer,
    "serviceFee": serviceFee,
    "royalFee": royalFee,
    "income": income,
    "price": price,
    "status": status,
    "startPrice": startPrice,
    "endPrice": endPrice,
    "deposit": deposit,
    "reserveCount": reserveCount,
    "winCount": winCount,
    "id": id,
    "time": time,
    "amount": amount,
    "originImgUrl": originImgUrl,
    "userName": userName,
    "from": from,
    "to": to,
    "fee": fee,
  };
}
