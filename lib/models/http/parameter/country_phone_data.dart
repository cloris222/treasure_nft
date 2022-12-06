// To parse this JSON data, do
//
//     final countryPhoneData = countryPhoneDataFromJson(jsonString);

import 'dart:convert';

CountryPhoneData countryPhoneDataFromJson(String str) =>
    CountryPhoneData.fromJson(json.decode(str));

String countryPhoneDataToJson(CountryPhoneData data) =>
    json.encode(data.toJson());

class CountryPhoneData {
  CountryPhoneData({
    required this.country,
    required this.areaCode,
  });

  String country;
  String areaCode;

  factory CountryPhoneData.fromJson(Map<String, dynamic> json) =>
      CountryPhoneData(
        country: json["country"],
        areaCode: json["areaCode"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "areaCode": areaCode,
      };
}
