// To parse this JSON data, do
//
//     final experienceInfo = experienceInfoFromJson(jsonString);

import 'dart:convert';

ExperienceInfo experienceInfoFromJson(String str) =>
    ExperienceInfo.fromJson(json.decode(str));

String experienceInfoToJson(ExperienceInfo data) => json.encode(data.toJson());

class ExperienceInfo {
  ExperienceInfo({
    this.isExperience = false,
    this.status = '',
  });

  bool isExperience;
  String status;

  factory ExperienceInfo.fromJson(Map<String, dynamic> json) => ExperienceInfo(
        isExperience: json["isExperience"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "isExperience": isExperience,
        "status": status,
      };
}
