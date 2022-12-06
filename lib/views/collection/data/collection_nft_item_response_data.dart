// To parse this JSON data, do
//
//     final collectionNftItemResponseData = collectionNftItemResponseDataFromJson(jsonString);

import 'dart:convert';

CollectionNftItemResponseData collectionNftItemResponseDataFromJson(String str) => CollectionNftItemResponseData.fromJson(json.decode(str));

String collectionNftItemResponseDataToJson(CollectionNftItemResponseData data) => json.encode(data.toJson());

class CollectionNftItemResponseData {
  CollectionNftItemResponseData({
    this.itemId = '',
    this.ownerId = '',
    this.name = '',
    this.imgUrl = '',
    this.price = '',
    this.settlePrice = '',
    this.growAmount = '',
    this.growPrice = '',
    this.status = '',
    this.nextTradeDate = '',
    this.tradePeriod = 0,
    this.boxOpen = '',
    required this.rewardNft,
  });

  String itemId;
  String ownerId;
  String name;
  String imgUrl;
  String price;
  String settlePrice;
  String growAmount;
  String growPrice;
  String status;
  String nextTradeDate;
  num tradePeriod;
  String boxOpen;
  RewardNft rewardNft;

  factory CollectionNftItemResponseData.fromJson(Map<String, dynamic> json) => CollectionNftItemResponseData(
    itemId: json["itemId"]??'',
    ownerId: json["ownerId"]??'',
    name: json["name"]??'',
    imgUrl: json["imgUrl"]??'',
    price: json["price"]??'',
    settlePrice: json["settlePrice"]??'',
    growAmount: json["growAmount"]??'',
    growPrice: json["growPrice"]??'',
    status: json["status"]??'',
    nextTradeDate: json["nextTradeDate"]??'',
    tradePeriod: json["tradePeriod"]??0,
    boxOpen: json["boxOpen"]??'',
    rewardNft: json["rewardNft"]!=null? RewardNft.fromJson(json["rewardNft"]) : RewardNft(),
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "ownerId": ownerId,
    "name": name,
    "imgUrl": imgUrl,
    "price": price,
    "settlePrice": settlePrice,
    "growAmount": growAmount,
    "growPrice": growPrice,
    "status": status,
    "nextTradeDate": nextTradeDate,
    "tradePeriod": tradePeriod,
    "boxOpen": boxOpen,
    "rewardNft": rewardNft.toJson(),
  };
}

class RewardNft {
  RewardNft({
    this.orderNo = '',
    this.itemId = '',
    this.currentLevel = 0,
    this.unlockLevel = 0,
    this.currentBuyCount = 0,
    this.unlockBuyCount = 0,
  });

  String orderNo;
  String itemId;
  num currentLevel;
  num unlockLevel;
  num currentBuyCount;
  num unlockBuyCount;

  factory RewardNft.fromJson(Map<String, dynamic> json) => RewardNft(
    orderNo: json["orderNo"]??'',
    itemId: json["itemId"]??'',
    currentLevel: json["currentLevel"]??0,
    unlockLevel: json["unlockLevel"]??0,
    currentBuyCount: json["currentBuyCount"]??0,
    unlockBuyCount: json["unlockBuyCount"]??0,
  );

  Map<String, dynamic> toJson() => {
    "orderNo": orderNo,
    "itemId": itemId,
    "currentLevel": currentLevel,
    "unlockLevel": unlockLevel,
    "currentBuyCount": currentBuyCount,
    "unlockBuyCount": unlockBuyCount,
  };
}
