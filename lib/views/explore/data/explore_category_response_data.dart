// To parse this JSON data, do
//
//     final exploreCatogoryResponseData = exploreCatogoryResponseDataFromJson(jsonString);

import 'dart:convert';

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
}
