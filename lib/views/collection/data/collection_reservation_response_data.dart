// To parse this JSON data, do
//
//     final collectionReservationResponseData = collectionReservationResponseDataFromJson(jsonString);

import 'dart:convert';

CollectionReservationResponseData collectionReservationResponseDataFromJson(String str) => CollectionReservationResponseData.fromJson(json.decode(str));

String collectionReservationResponseDataToJson(CollectionReservationResponseData data) => json.encode(data.toJson());

class CollectionReservationResponseData {
  CollectionReservationResponseData({
    this.orderNo = '',
    this.type = '',
    this.createdAt = '',
    this.itemId = '',
    this.itemName = '',
    this.imgUrl = '',
    this.status = '',
    this.winCount = 0,
    this.reserveCount = 0,
    this.deposit = 0,
    this.startPrice = 0,
    this.endPrice = 0,
    this.price = 0,
  });

  String orderNo;
  String type;
  String createdAt;
  String itemId;
  String itemName;
  String imgUrl;
  String status;
  num winCount;
  num reserveCount;
  num deposit;
  num startPrice;
  num endPrice;
  num price;

  factory CollectionReservationResponseData.fromJson(Map<String, dynamic> json) => CollectionReservationResponseData(
    orderNo: json["orderNo"]??'',
    type: json["type"]??'',
    createdAt: json["createdAt"]??'',
    itemId: json["itemId"]??'',
    itemName: json["itemName"]??'',
    imgUrl: json["imgUrl"]??'',
    status: json["status"]??'',
    winCount: json["winCount"]??0,
    reserveCount: json["reserveCount"]??0,
    deposit: json["deposit"]??0,
    startPrice: json["startPrice"]??0,
    endPrice: json["endPrice"]??0,
    price: json["price"]??0,
  );

  Map<String, dynamic> toJson() => {
    "orderNo": orderNo,
    "type": type,
    "createdAt": createdAt,
    "itemId": itemId,
    "itemName": itemName,
    "imgUrl": imgUrl,
    "status": status,
    "winCount": winCount,
    "reserveCount": reserveCount,
    "deposit": deposit,
    "startPrice": startPrice,
    "endPrice": endPrice,
    "price": price,
  };
}
