// To parse this JSON data, do
//
//     final airdropBoxInfo = airdropBoxInfoFromJson(jsonString);

import 'dart:convert';

AirdropBoxInfo airdropBoxInfoFromJson(String str) =>
    AirdropBoxInfo.fromJson(json.decode(str));

String airdropBoxInfoToJson(AirdropBoxInfo data) => json.encode(data.toJson());

class AirdropBoxInfo {
  AirdropBoxInfo({
    required this.orderNo,
    required this.createdAt,
    required this.account,
    required this.name,
    required this.type,
    required this.country,
    required this.boxType,
    required this.medal,
    required this.itemName,
    required this.itemPrice,
    required this.reward,
    required this.status,
    required this.medalName,
    required this.imgUrl,
  });

  /// 訂單編號
  final String orderNo;

  /// 建立時間
  final String createdAt;

  /// 會員帳號
  final String account;

  /// 會員名稱
  final String name;

  /// 會員類型
  final String type;

  /// 會員國家
  final String country;

  /// 寶箱類型
  final String boxType;

  /// 獎章
  final String medal;

  /// 獎章名稱
  final String medalName;

  /// 商品名稱
  final String itemName;

  /// 商品金額
  final num itemPrice;

  /// 商品圖片
  final String imgUrl;

  /// 獎勵金額
  final num reward;

  /// 狀態
  final String status;

  factory AirdropBoxInfo.fromJson(Map<String, dynamic> json) => AirdropBoxInfo(
        orderNo: json["orderNo"] ?? "",
        createdAt: json["createdAt"] ?? "",
        account: json["account"] ?? "",
        name: json["name"] ?? "",
        type: json["type"] ?? "",
        country: json["country"] ?? "",
        boxType: json["boxType"] ?? "",
        medal: json["medal"] ?? "",
        itemName: json["itemName"] ?? "",
        itemPrice: json["itemPrice"] ?? 0,
        reward: json["reward"] ?? 0,
        status: json["status"] ?? "",
        medalName: json["medalName"] ?? "",
        imgUrl: json["imgUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "orderNo": orderNo,
        "createdAt": createdAt,
        "account": account,
        "name": name,
        "type": type,
        "country": country,
        "boxType": boxType,
        "medal": medal,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "reward": reward,
        "status": status,
        "medalName": medalName,
        "imgUrl": imgUrl,
      };

  bool isOpen() {
    return status.compareTo("OPENED") == 0;
  }
}
