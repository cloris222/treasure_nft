// To parse this JSON data, do
//
//     final userOrderInfo = userOrderInfoFromJson(jsonString);

import 'dart:convert';

UserOrderInfo userOrderInfoFromJson(String str) => UserOrderInfo.fromJson(json.decode(str));

String userOrderInfoToJson(UserOrderInfo data) => json.encode(data.toJson());

class UserOrderInfo {
  UserOrderInfo({
    required this.total,
    required this.pending,
    required this.bought,
    required this.sold,
  });

  int total;
  int pending;
  int bought;
  int sold;

  factory UserOrderInfo.fromJson(Map<String, dynamic> json) => UserOrderInfo(
    total: json["total"],
    pending: json["pending"],
    bought: json["bought"],
    sold: json["sold"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "pending": pending,
    "bought": bought,
    "sold": sold,
  };
}
