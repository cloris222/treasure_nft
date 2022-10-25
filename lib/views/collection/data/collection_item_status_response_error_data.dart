// To parse this JSON data, do
//
//     final collectionItemStatusResponseErrorData = collectionItemStatusResponseErrorDataFromJson(jsonString);

import 'dart:convert';

CollectionItemStatusResponseErrorData collectionItemStatusResponseErrorDataFromJson(String str) => CollectionItemStatusResponseErrorData.fromJson(json.decode(str));

String collectionItemStatusResponseErrorDataToJson(CollectionItemStatusResponseErrorData data) => json.encode(data.toJson());

class CollectionItemStatusResponseErrorData {
  CollectionItemStatusResponseErrorData({
    this.zone = '',
    this.startTime = '',
    this.endTime = '',
  });

  String zone;
  String startTime;
  String endTime;

  factory CollectionItemStatusResponseErrorData.fromJson(Map<String, dynamic> json) => CollectionItemStatusResponseErrorData(
    zone: json["zone"],
    startTime: json["startTime"],
    endTime: json["endTime"],
  );

  Map<String, dynamic> toJson() => {
    "zone": zone,
    "startTime": startTime,
    "endTime": endTime,
  };
}
