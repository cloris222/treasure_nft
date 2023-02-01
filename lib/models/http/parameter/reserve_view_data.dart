// To parse this JSON data, do
//
//     final reserveViewData = reserveViewDataFromJson(jsonString);

import 'dart:convert';

ReserveViewData reserveViewDataFromJson(String str) =>
    ReserveViewData.fromJson(json.decode(str));

String reserveViewDataToJson(ReserveViewData data) =>
    json.encode(data.toJson());

class ReserveViewData {
  ReserveViewData({
    required this.vol,
    required this.swapFree,
    required this.annualRoi,
    required this.price,
    required this.rol,
    required this.apr,
  });

  num vol;
  num swapFree;
  num annualRoi;
  num price;
  num rol;
  num apr;

  factory ReserveViewData.fromJson(Map<String, dynamic> json) =>
      ReserveViewData(
        vol: json["vol"] ?? 0,
        swapFree: json["swapFree"] ?? 0,
        annualRoi: json["annualRoi"] ?? 0,
        price: json["price"] ?? 0,
        rol: json["rol"] ?? 0,
        apr: json["apr"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "vol": vol,
        "swapFree": swapFree,
        "annualRoi": annualRoi,
        "price": price,
        "rol": rol,
        "apr": apr,
      };
}
