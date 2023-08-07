// To parse this JSON data, do
//
//     final payTypeData = payTypeDataFromJson(jsonString);

import 'dart:convert';

AisleTypeData aisleTypeDataFromJson(String str) => AisleTypeData.fromJson(json.decode(str));

String aisleTypeDataToJson(AisleTypeData data) => json.encode(data.toJson());

class AisleTypeData {
  AisleTypeData({
    this.route = "",
    this.payType = "",
    this.startPrice = 0.0,
    this.endPrice = 0.0,
    this.currency = "",
    this.currentRate = 0.0,
  });

  String route;
  String payType;
  double startPrice;
  double endPrice;
  String currency;
  double currentRate;

  factory AisleTypeData.fromJson(Map<String, dynamic> json) => AisleTypeData(
    route: json["route"]??'',
    payType: json["payType"]??'',
    startPrice: json["startPrice"]?? 0.0.toDouble(),
    endPrice: json["endPrice"]?? 0.0.toDouble(),
    currency: json["currency"]?? '',
    currentRate: json["currentRate"]?? 0.0.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "route": route,
    "payType": payType,
    "startPrice": startPrice,
    "endPrice": endPrice,
    "currency": currency,
    "currentRate": currentRate,
  };
}
