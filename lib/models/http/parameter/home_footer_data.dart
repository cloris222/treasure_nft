// To parse this JSON data, do
//
//     final homeFooterData = homeFooterDataFromJson(jsonString);

import 'dart:convert';

HomeFooterData homeFooterDataFromJson(String str) =>
    HomeFooterData.fromJson(json.decode(str));

String homeFooterDataToJson(HomeFooterData data) => json.encode(data.toJson());

class HomeFooterData {
  HomeFooterData({
    required this.id,
    required this.name,
    required this.link,
    required this.status,
  });

  int id;
  String name;
  String link;
  String status;

  factory HomeFooterData.fromJson(Map<String, dynamic> json) => HomeFooterData(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
        "status": status,
      };
}
