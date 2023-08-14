// To parse this JSON data, do
//
//     final stationLetterData = stationLetterDataFromJson(jsonString);

import 'dart:convert';

class StationLetterData {
  final String id;
  final String title;
  final String content;
  final bool isRead;

  StationLetterData({
    required this.id,
    required this.title,
    required this.content,
    required this.isRead,
  });

  StationLetterData copyWith({
    String? id,
    String? title,
    String? content,
    bool? isRead,
  }) =>
      StationLetterData(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        isRead: isRead ?? this.isRead,
      );

  factory StationLetterData.fromRawJson(String str) => StationLetterData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StationLetterData.fromJson(Map<String, dynamic> json) => StationLetterData(
    id: json["id"]??"",
    title: json["title"]??"",
    content: json["content"]??"",
    isRead: json["isRead"]??true,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "isRead": isRead,
  };
}
