// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);
import 'package:treasure_nft_project/constant/global_data.dart';
import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    required this.code,
    required this.message,
    this.data,
  });

  String code;
  String message;
  dynamic data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
      code: json["code"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
      };

  void printLog(){
    GlobalData.printLog('===========printLog===========');
    GlobalData.printLog('code:$code');
    GlobalData.printLog('message:$message');
    GlobalData.printLog('data:$data');
  }
}
