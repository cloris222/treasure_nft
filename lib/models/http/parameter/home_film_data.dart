import 'dart:convert';

HomeFilmData homeFilmFromJson(String str) => HomeFilmData.fromJson(json.decode(str));

String homeFilmToJson(HomeFilmData data) => json.encode(data.toJson());

class HomeFilmData {
  HomeFilmData({
    this.id = '',
    this.name = '',
    this.link = '',
    this.cover = '',
  });

  String id;
  String name;
  String link;
  String cover;

  factory HomeFilmData.fromJson(Map<String, dynamic> json) => HomeFilmData(
    id: json["id"].toString(),
    name: json["name"].toString(),
    link: json["link"].toString(),
    cover: json["cover"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "cover": cover,
  };
}