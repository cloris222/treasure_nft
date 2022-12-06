// To parse this JSON data, do
//
//     final tradingVolumeData = tradingVolumeDataFromJson(jsonString);

import 'dart:convert';

TradingVolumeData tradingVolumeDataFromJson(String str) =>
    TradingVolumeData.fromJson(json.decode(str));

String tradingVolumeDataToJson(TradingVolumeData data) =>
    json.encode(data.toJson());

class TradingVolumeData {
  TradingVolumeData({
    required this.transactionAmount,
    required this.cost,
    required this.nfts,
  });

  String transactionAmount;
  String cost;
  String nfts;

  factory TradingVolumeData.fromJson(Map<String, dynamic> json) =>
      TradingVolumeData(
        transactionAmount: json["transactionAmount"],
        cost: json["cost"],
        nfts: json["nfts"],
      );

  Map<String, dynamic> toJson() => {
        "transactionAmount": transactionAmount,
        "cost": cost,
        "nfts": nfts,
      };
}
