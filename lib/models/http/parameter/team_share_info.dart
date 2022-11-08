// To parse this JSON data, do
//
//     final teamShareInfo = teamShareInfoFromJson(jsonString);

import 'dart:convert';

TeamShareInfo teamShareInfoFromJson(String str) =>
    TeamShareInfo.fromJson(json.decode(str));

String teamShareInfoToJson(TeamShareInfo data) => json.encode(data.toJson());

class TeamShareInfo {
  TeamShareInfo({
    required this.day,
    required this.promotePct,
  });

  int day;
  double promotePct;

  factory TeamShareInfo.fromJson(Map<String, dynamic> json) => TeamShareInfo(
        day: json["day"],
        promotePct: json["promotePCT"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "promotePCT": promotePct,
      };
}
