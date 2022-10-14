// To parse this JSON data, do
//
//     final addNewReservation = addNewReservationFromJson(jsonString);

import 'dart:convert';

AddNewReservation addNewReservationFromJson(String str) =>
    AddNewReservation.fromJson(json.decode(str));

String addNewReservationToJson(AddNewReservation data) =>
    json.encode(data.toJson());

class AddNewReservation {
  AddNewReservation({
    required this.type,
    required this.reserveCount,
    required this.startPrice,
    required this.endPrice,
    required this.priceIndex,
  });

  String type;
  int reserveCount;
  int startPrice;
  int endPrice;
  int priceIndex;

  factory AddNewReservation.fromJson(Map<String, dynamic> json) =>
      AddNewReservation(
        type: json["type"],
        reserveCount: json["reserveCount"],
        startPrice: json["startPrice"],
        endPrice: json["endPrice"],
        priceIndex: json["priceIndex"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "reserveCount": reserveCount,
        "startPrice": startPrice,
        "endPrice": endPrice,
        "priceIndex": priceIndex,
      };
}
