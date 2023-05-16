// To parse this JSON data, do
//
//     final googleAuthData = googleAuthDataFromJson(jsonString);

import 'dart:convert';

GoogleAuthData googleAuthDataFromJson(String str) => GoogleAuthData.fromJson(json.decode(str));

String googleAuthDataToJson(GoogleAuthData data) => json.encode(data.toJson());

class GoogleAuthData {
  String qrCode;
  String secretKey;

  GoogleAuthData({
    this.qrCode = '',
    this.secretKey = '',
  });

  factory GoogleAuthData.fromJson(Map<String, dynamic> json) => GoogleAuthData(
    qrCode: json["qrCode"]??'',
    secretKey: json["secretKey"]??'',
  );

  Map<String, dynamic> toJson() => {
    "qrCode": qrCode,
    "secretKey": secretKey,
  };
}
