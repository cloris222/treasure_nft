// To parse this JSON data, do
//
//     final homeCarousel = homeCarouselFromJson(jsonString);

import 'dart:convert';

HomeCarousel homeCarouselFromJson(String str) =>
    HomeCarousel.fromJson(json.decode(str));

String homeCarouselToJson(HomeCarousel data) => json.encode(data.toJson());

class HomeCarousel {
  HomeCarousel({
    required this.itemId,
    required this.name,
    required this.creator,
    required this.avatarUrl,
    required this.imageUrl,
    required this.currentPrice,
    required this.startTime,
  });

  String itemId;
  String name;
  String creator;
  String avatarUrl;
  String imageUrl;
  num currentPrice;
  String startTime;

  factory HomeCarousel.fromJson(Map<String, dynamic> json) => HomeCarousel(
        itemId: json["itemId"] ?? '',
        name: json["name"] ?? '',
        creator: json["creator"] ?? '',
        avatarUrl: json["avatarUrl"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        currentPrice: json["currentPrice"] ?? 0,
        startTime: json["startTime"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "name": name,
        "creator": creator,
        "avatarUrl": avatarUrl,
        "imageUrl": imageUrl,
        "currentPrice": currentPrice,
        "startTime": startTime,
      };
}
