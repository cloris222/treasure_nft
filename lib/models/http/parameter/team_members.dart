// To parse this JSON data, do
//
//     final teamMembers = teamMembersFromJson(jsonString);

import 'dart:convert';

TeamMembers teamMembersFromJson(String str) => TeamMembers.fromJson(json.decode(str));

String teamMembersToJson(TeamMembers data) => json.encode(data.toJson());

class TeamMembers {
  TeamMembers({
    this.totalUser,
    this.direct,
    this.indirect,
    this.third,
    this.totalActive,
    this.activeDirect,
    this.activeIndirect,
    this.activeThird,
  });

  dynamic totalUser;
  dynamic direct;
  dynamic indirect;
  dynamic third;
  dynamic totalActive;
  dynamic activeDirect;
  dynamic activeIndirect;
  dynamic activeThird;

  factory TeamMembers.fromJson(Map<String, dynamic> json) => TeamMembers(
    totalUser: json["totalUser"],
    direct: json["direct"],
    indirect: json["indirect"],
    third: json["third"],
    totalActive: json["totalActive"],
    activeDirect: json["activeDirect"],
    activeIndirect: json["activeIndirect"],
    activeThird: json["activeThird"],
  );

  Map<String, dynamic> toJson() => {
    "totalUser": totalUser,
    "direct": direct,
    "indirect": indirect,
    "third": third,
    "totalActive": totalActive,
    "activeDirect": activeDirect,
    "activeIndirect": activeIndirect,
    "activeThird": activeThird,
  };
}
