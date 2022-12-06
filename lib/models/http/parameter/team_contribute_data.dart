
import 'dart:convert';

TeamContribute teamContributeFromJson(String str) => TeamContribute.fromJson(json.decode(str));

String teamContributeToJson(TeamContribute data) => json.encode(data.toJson());

class TeamContribute {
  TeamContribute({
    this.teamShare,
    this.directShare,
    this.indirectShare,
    this.thirdShare,
  });

  dynamic teamShare;
  dynamic directShare;
  dynamic indirectShare;
  dynamic thirdShare;

  factory TeamContribute.fromJson(Map<String, dynamic> json) => TeamContribute(
    teamShare: json["teamShare"],
    directShare: json["directShare"],
    indirectShare: json["indirectShare"],
    thirdShare: json["thirdShare"],
  );

  Map<String, dynamic> toJson() => {
    "teamShare": teamShare,
    "directShare": directShare,
    "indirectShare": indirectShare,
    "thirdShare": thirdShare,
  };
}
