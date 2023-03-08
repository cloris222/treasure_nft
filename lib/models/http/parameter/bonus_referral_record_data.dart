// To parse this JSON data, do
//
//     final bonusReferralRecordData = bonusReferralRecordDataFromJson(jsonString);

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:format/format.dart';

BonusReferralRecordData bonusReferralRecordDataFromJson(String str) =>
    BonusReferralRecordData.fromJson(json.decode(str));

String bonusReferralRecordDataToJson(BonusReferralRecordData data) =>
    json.encode(data.toJson());

class BonusReferralRecordData {
  BonusReferralRecordData({
    required this.itemName,
    required this.orderLevel,
    required this.createdAt,
    required this.imgUrl,
    required this.orderNo,
    required this.makerName,
    required this.spreadSavingsRate,
    required this.income,
    required this.price,
  });

  String itemName;
  String orderLevel;
  DateTime createdAt;
  String imgUrl;
  String orderNo;
  String makerName;
  num spreadSavingsRate;
  num income;
  num price;

  factory BonusReferralRecordData.fromJson(Map<String, dynamic> json) =>
      BonusReferralRecordData(
        itemName: json["itemName"] ?? '',
        orderLevel: json["orderLevel"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        imgUrl: json["imgUrl"] ?? '',
        orderNo: json["orderNo"] ?? '',
        makerName: json["makerName"] ?? '',
        spreadSavingsRate: json["spreadSavingsRate"] ?? 0,
        income: json["income"] ?? 0,
        price: json["price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "orderLevel": orderLevel,
        "createdAt": createdAt.toIso8601String(),
        "imgUrl": imgUrl,
        "orderNo": orderNo,
        "makerName": makerName,
        "spreadSavingsRate": spreadSavingsRate,
        "income": income,
        "price": price,
      };

  String getLevelOrder() {
    String level = '';
    switch (orderLevel) {
      case 'ORDER_LEVEL_A':
        {
          level = 'A';
        }
        break;
      case 'ORDER_LEVEL_B':
        {
          level = 'B';
        }
        break;
      case 'ORDER_LEVEL_C':
        {
          level = 'C';
        }
        break;
    }

    return format(tr('classOrder'), {'level': level});
  }
}
