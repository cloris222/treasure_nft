import 'dart:convert';

HomeCarousel homeCarouselFromJson(String str) => HomeCarousel.fromJson(json.decode(str));

String homeCarouselToJson(HomeCarousel data) => json.encode(data.toJson());

class HomeCarousel {
  HomeCarousel({
    this.itemId = '',
    this.name = '',
    this.imageUrl = '',
  });

  String itemId;
  String name;
  String imageUrl;

  factory HomeCarousel.fromJson(Map<String, dynamic> json) => HomeCarousel(
    itemId: json["itemId"],
    name: json["name"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "name": name,
    "imageUrl": imageUrl,
  };
}
