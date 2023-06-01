// To parse this JSON data, do
//
//     final announceData = announceDataFromJson(jsonString);

import 'dart:convert';

AnnounceData announceDataFromJson(String str) => AnnounceData.fromJson(json.decode(str));

String announceDataToJson(AnnounceData data) => json.encode(data.toJson());

class AnnounceData {
  int id;
  String title;
  String content;
  List<String> tagId;
  String bannerMbUrl;
  String bannerPcUrl;
  String startAt;
  String endAt;
  int sort;

  AnnounceData({
    this.id = 0,
    this.title = '',
    this.content = '',
    this.tagId = const[],
    this.bannerMbUrl = '',
    this.bannerPcUrl = '',
    this.startAt = '',
    this.endAt = '',
    this.sort = 0,
  });

  factory AnnounceData.fromJson(Map<String, dynamic> json) => AnnounceData(
    id: json["id"]??0,
    title: json["title"]??'',
    content: json["content"]??'',
    tagId: List<String>.from(json["tagId"].map((x) => x)),
    bannerMbUrl: json["bannerMbUrl"]??'',
    bannerPcUrl: json["bannerPcUrl"]??'',
    startAt: json["startAt"]??'',
    endAt: json["endAt"]??'',
    sort: json["sort"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "tagId": List<dynamic>.from(tagId.map((x) => x.toString())),
    "bannerMbUrl": bannerMbUrl,
    "bannerPcUrl": bannerPcUrl,
    "startAt": startAt,
    "endAt": endAt,
    "sort": sort,
  };
}


AnnounceTagData announceTagDataFromJson(String str) => AnnounceTagData.fromJson(json.decode(str));

String announceTagDataToJson(AnnounceTagData data) => json.encode(data.toJson());

class AnnounceTagData {
  int id;
  String title;
  String color;

  AnnounceTagData({
    this.id = 0,
    this.title = '',
    this.color = '',
  });

  factory AnnounceTagData.fromJson(Map<String, dynamic> json) => AnnounceTagData(
    id: json["id"]??0,
    title: json["title"]??'',
    color: json["color"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "color": color,
  };
}

