// To parse this JSON data, do
//
//     final collectionTicketResponseData = collectionTicketResponseDataFromJson(jsonString);

import 'dart:convert';

CollectionTicketResponseData collectionTicketResponseDataFromJson(String str) => CollectionTicketResponseData.fromJson(json.decode(str));

String collectionTicketResponseDataToJson(CollectionTicketResponseData data) => json.encode(data.toJson());

class CollectionTicketResponseData {
  CollectionTicketResponseData({
    this.orderNo = '',
    this.type = '',
    this.createdAt = '',
    this.lotteryNo = '',
    this.deposit = 0,
    this.ticketValue = 0,
    this.itemName = '',
    this.imgUrl = '',
    this.itemPrice = 0,
    this.itemStatus = '',
    this.winPrize = 0,
    this.winPrizeAmount = 0,
    this.winPrizeStatus = '',
  });

  String orderNo;
  String type;
  String createdAt;
  String lotteryNo;
  num deposit;
  num ticketValue;
  String itemName;
  String imgUrl;
  num itemPrice;
  String itemStatus;
  num winPrize;
  num winPrizeAmount;
  String winPrizeStatus;

  factory CollectionTicketResponseData.fromJson(Map<String, dynamic> json) => CollectionTicketResponseData(
    orderNo: json["orderNo"],
    type: json["type"],
    createdAt: json["createdAt"],
    lotteryNo: json["lotteryNo"],
    deposit: json["deposit"],
    ticketValue: json["ticketValue"],
    itemName: json["itemName"],
    imgUrl: json["imgUrl"],
    itemPrice: json["itemPrice"],
    itemStatus: json["itemStatus"],
    winPrize: json["winPrize"],
    winPrizeAmount: json["winPrizeAmount"],
    winPrizeStatus: json["winPrizeStatus"],
  );

  Map<String, dynamic> toJson() => {
    "orderNo": orderNo,
    "type": type,
    "createdAt": createdAt,
    "lotteryNo": lotteryNo,
    "deposit": deposit,
    "ticketValue": ticketValue,
    "itemName": itemName,
    "imgUrl": imgUrl,
    "itemPrice": itemPrice,
    "itemStatus": itemStatus,
    "winPrize": winPrize,
    "winPrizeAmount": winPrizeAmount,
    "winPrizeStatus": winPrizeStatus,
  };
}
