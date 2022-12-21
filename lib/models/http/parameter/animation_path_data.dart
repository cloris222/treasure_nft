// To parse this JSON data, do
//
//     final animationPathData = animationPathDataFromJson(jsonString);

import 'dart:convert';

AnimationPathData animationPathDataFromJson(String str) =>
    AnimationPathData.fromJson(json.decode(str));

String animationPathDataToJson(AnimationPathData data) =>
    json.encode(data.toJson());

class AnimationPathData {
  AnimationPathData({
    required this.name,
    required this.url,
    required this.size,
  });

  String name;
  String url;
  int size;

  factory AnimationPathData.fromJson(Map<String, dynamic> json) =>
      AnimationPathData(
        name: json["name"] ?? '',
        url: json["url"] ?? '',
        size: json["size"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "size": size,
      };
}
