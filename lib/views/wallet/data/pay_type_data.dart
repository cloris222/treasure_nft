// To parse this JSON data, do
//
//     final payTypeData = payTypeDataFromJson(jsonString);

import 'dart:convert';

PayTypeData payTypeDataFromJson(String str) => PayTypeData.fromJson(json.decode(str));

String payTypeDataToJson(PayTypeData data) => json.encode(data.toJson());

class PayTypeData {
  PayTypeData({
    this.type = '',
    this.startPrice = 0.0,
    this.endPrice = 0.0,
    this.currency = '',
    this.currentRate = 0.0,
  });

  String type;
  double startPrice;
  double endPrice;
  String currency;
  double currentRate;

  factory PayTypeData.fromJson(Map<String, dynamic> json) => PayTypeData(
    type: json["type"]??'',
    startPrice: json["startPrice"]?? 0.0.toDouble(),
    endPrice: json["endPrice"]?? 0.0.toDouble(),
    currency: json["currency"]?? '',
    currentRate: json["currentRate"]?? 0.0.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "startPrice": startPrice,
    "endPrice": endPrice,
    "currency": currency,
    "currentRate": currentRate,
  };
}
