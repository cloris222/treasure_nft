// To parse this JSON data, do
//
//     final collectionNftItemResponseData = collectionNftItemResponseDataFromJson(jsonString);

import 'dart:convert';

CollectionNftItemResponseData collectionNftItemResponseDataFromJson(String str) => CollectionNftItemResponseData.fromJson(json.decode(str));

String collectionNftItemResponseDataToJson(CollectionNftItemResponseData data) => json.encode(data.toJson());

class CollectionNftItemResponseData {
  CollectionNftItemResponseData({
    this.itemId = '',
    this.name = '',
    this.imgUrl = '',
    this.price = '',
    this.growAmount = '',
    this.growPrice = '',
    this.status = '',
    this.nextTradeDate = '',
    this.tradePeriod = '',
  });

  String itemId;
  String name;
  String imgUrl;
  String status;
  String nextTradeDate;
  String price;
  String growAmount;
  String growPrice;
  String tradePeriod;

  factory CollectionNftItemResponseData.fromJson(Map<String, dynamic> json) => CollectionNftItemResponseData(
    itemId: json["itemId"]??'',
    name: json["name"]??'',
    imgUrl: json["imgUrl"]??'',
    price: json["price"]??'',
    growAmount: json["growAmount"]??'',
    growPrice: json["growPrice"]??'',
    status: json["status"]??'',
    nextTradeDate: json["nextTradeDate"]??'',
    tradePeriod: json["tradePeriod"]??'',
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "name": name,
    "imgUrl": imgUrl,
    "price": price,
    "growAmount": growAmount,
    "growPrice": growPrice,
    "status": status,
    "nextTradeDate": nextTradeDate,
    "tradePeriod": tradePeriod,
  };
}
