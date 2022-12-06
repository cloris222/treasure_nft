// To parse this JSON data, do
//
//     final exploreItemResponseData = exploreItemResponseDataFromJson(jsonString);

import 'dart:convert';

ExploreItemResponseData exploreItemResponseDataFromJson(String str) => ExploreItemResponseData.fromJson(json.decode(str));

String exploreItemResponseDataToJson(ExploreItemResponseData data) => json.encode(data.toJson());

class ExploreItemResponseData {
  ExploreItemResponseData({
    this.itemId = '',
    this.name = '',
    this.imgUrl = '',
    this.ownerName = '',
    this.price = '',
    this.growAmount = '',
    this.startAt = '',
    required this.priceHistory,
    required this.sellTimeList,
  });

  String itemId;
  String name;
  String imgUrl;
  String ownerName;
  String price;
  String growAmount;
  String startAt;
  List<PriceHistory> priceHistory;
  List<SellTimeList> sellTimeList;

  factory ExploreItemResponseData.fromJson(Map<String, dynamic> json) => ExploreItemResponseData(
    itemId: json["itemId"]??'',
    name: json["name"]??'',
    imgUrl: json["imgUrl"]??'',
    ownerName: json["ownerName"]??'',
    price: json["price"]??'',
    growAmount: json["growAmount"]??'',
    startAt: json["startAt"]??'',
    priceHistory: List<PriceHistory>.from(json["priceHistory"].map((x) => PriceHistory.fromJson(x))),
    sellTimeList: List<SellTimeList>.from(json["sellTimeList"].map((x) => SellTimeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "name": name,
    "imgUrl": imgUrl,
    "ownerName": ownerName,
    "price": price,
    "growAmount": growAmount,
    "startAt": startAt,
    "priceHistory": List<dynamic>.from(priceHistory.map((x) => x.toJson())),
    "sellTimeList": List<dynamic>.from(sellTimeList.map((x) => x.toJson())),
  };
}

class PriceHistory {
  PriceHistory({
    this.price = '',
    this.date = '',
  });

  String price;
  String date;

  factory PriceHistory.fromJson(Map<String, dynamic> json) => PriceHistory(
    price: json["price"]??'',
    date: json["date"]??'',
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "date": date,
  };
}

class SellTimeList {
  SellTimeList({
    this.country = '',
    this.zone = '',
    this.localTime = '',
    this.startTime = '',
    this.endTime = '',
    this.sellDate = '',
  });

  String country;
  String zone;
  String localTime;
  String startTime;
  String endTime;
  String sellDate;

  factory SellTimeList.fromJson(Map<String, dynamic> json) => SellTimeList(
    country: json["country"]??'',
    zone: json["zone"]??'',
    localTime: json["localTime"]??'',
    startTime: json["startTime"]??'',
    endTime: json["endTime"]??'',
    sellDate: json["sellDate"]??'',
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "zone": zone,
    "localTime": localTime,
    "startTime": startTime,
    "endTime": endTime,
    "sellDate": sellDate,
  };
}
