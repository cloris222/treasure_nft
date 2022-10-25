// To parse this JSON data, do
//
//     final collectionLevelFeeResponseData = collectionLevelFeeResponseDataFromJson(jsonString);

import 'dart:convert';

CollectionLevelFeeResponseData collectionLevelFeeResponseDataFromJson(String str) => CollectionLevelFeeResponseData.fromJson(json.decode(str));

String collectionLevelFeeResponseDataToJson(CollectionLevelFeeResponseData data) => json.encode(data.toJson());

class CollectionLevelFeeResponseData {
  CollectionLevelFeeResponseData({
    this.feeRate = 0,
    this.royalRate = 0,
  });

  dynamic feeRate;
  dynamic royalRate;

  factory CollectionLevelFeeResponseData.fromJson(Map<String, dynamic> json) => CollectionLevelFeeResponseData(
    feeRate: json["feeRate"],
    royalRate: json["royalRate"],
  );

  Map<String, dynamic> toJson() => {
    "feeRate": feeRate,
    "royalRate": royalRate,
  };
}
