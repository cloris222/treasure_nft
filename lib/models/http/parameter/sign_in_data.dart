// To parse this JSON data, do
//
//     final signInData = signInDataFromJson(jsonString);

import 'dart:convert';

SignInData signInDataFromJson(String str) => SignInData.fromJson(json.decode(str));

String signInDataToJson(SignInData data) => json.encode(data.toJson());
///MARK: 登入天數
class SignInData {
  SignInData({
    required this.isFinished,
    required this.point,
    required this.finishedDateList,
  });

  bool isFinished;
  int point;
  List<String> finishedDateList;

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
    isFinished: json["isFinished"],
    point: json["point"],
    finishedDateList: List<String>.from(json["finishedDateList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "isFinished": isFinished,
    "point": point,
    "finishedDateList": List<dynamic>.from(finishedDateList.map((x) => x)),
  };
}
