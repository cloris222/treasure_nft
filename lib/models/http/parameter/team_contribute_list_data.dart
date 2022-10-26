
import 'dart:convert';

TeamContributeList teamContributeListFromJson(String str) => TeamContributeList.fromJson(json.decode(str));

String teamContributeListToJson(TeamContributeList data) => json.encode(data.toJson());

class TeamContributeList {
  TeamContributeList({
    this.account = '',
    this.name = '',
    this.related = '',
    this.share,
  });

  String account;
  String name;
  String related;
  dynamic share;

  factory TeamContributeList.fromJson(Map<String, dynamic> json) => TeamContributeList(
    account: json["account"],
    name: json["name"],
    related: json["related"],
    share: json["share"],
  );

  Map<String, dynamic> toJson() => {
    "account": account,
    "name": name,
    "related": related,
    "share": share,
  };
}
