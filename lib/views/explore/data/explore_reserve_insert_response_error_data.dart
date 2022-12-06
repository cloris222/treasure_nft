// To parse this JSON data, do
//
//     final exploreReserveInsertResponseErrorData = exploreReserveInsertResponseErrorDataFromJson(jsonString);

import 'dart:convert';

ExploreReserveInsertResponseErrorData exploreReserveInsertResponseErrorDataFromJson(String str) => ExploreReserveInsertResponseErrorData.fromJson(json.decode(str));

String exploreReserveInsertResponseErrorDataToJson(ExploreReserveInsertResponseErrorData data) => json.encode(data.toJson());

class ExploreReserveInsertResponseErrorData {
  ExploreReserveInsertResponseErrorData({
    this.level = 0,
    this.needLevel = 0,
  });

  int level;
  int needLevel;

  factory ExploreReserveInsertResponseErrorData.fromJson(Map<String, dynamic> json) => ExploreReserveInsertResponseErrorData(
    level: json["level"]??0,
    needLevel: json["needLevel"]??0,
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "needLevel": needLevel,
  };
}
