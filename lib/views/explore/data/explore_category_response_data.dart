// To parse this JSON data, do
//
//     final exploreCatogoryResponseData = exploreCatogoryResponseDataFromJson(jsonString);

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

ExploreCategoryResponseData exploreCategoryResponseDataFromJson(String str) => ExploreCategoryResponseData.fromJson(json.decode(str));

String exploreCategoryResponseDataToJson(ExploreCategoryResponseData data) => json.encode(data.toJson());

class ExploreCategoryResponseData {
  ExploreCategoryResponseData({
    this.name = '',
    this.frontName = '',
  });

  String name;
  String frontName;

  factory ExploreCategoryResponseData.fromJson(Map<String, dynamic> json) => ExploreCategoryResponseData(
    name: json["name"],
    frontName: json["frontName"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "frontName": frontName,
  };


  String getTabTitle() {
    switch (name) {
      case '':
        return tr('TopPicks');
      case 'polygonNFT':
        return tr('polygonNFT');
      case 'artwork':
        return tr('art');
      case 'collection':
        return tr('collectibles');
    // case 'bscNFT':
    //   return tr('bSCNFT');
    // case 'domain':
    //   return tr('domainNames');
    // case 'ercNFT':
    //   return tr('eRCNFT');
    // case 'facility':
    //   return tr('utility');
    // case 'music':
    //   return tr('music');
    // case 'photo':
    //   return tr('photography');
    // case 'sport':
    //   return tr('sports');
    // case 'tradeCard':
    //   return tr('tradingCards');
    }
    return '';
  }
}
