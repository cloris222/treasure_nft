// To parse this JSON data, do
//
//     final uploadImage = uploadImageFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../constant/global_data.dart';

UploadImageAndVideo uploadImageFromJson(String str) =>
    UploadImageAndVideo.fromJson(json.decode(str));

String uploadImageToJson(UploadImageAndVideo data) =>
    json.encode(data.toJson());

class UploadImageAndVideo {
  UploadImageAndVideo(
      {this.fileType = 'img',
      required this.file,
      required this.uploadOriginalName});

  String fileName = '';
  String fileType;
  bool uploadOriginalName;
  File file;

  factory UploadImageAndVideo.fromJson(Map<String, dynamic> json) =>
      UploadImageAndVideo(
        fileType: json["fileType"],
        file: json["file"],
        uploadOriginalName: false,
      );

  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileType": fileType,
        "file": file,
      };

  ///MARK 轉成dio要的上傳資料格式
  formData({String? setFileName}) async {
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    fileName =
        '${GlobalData.userMemberId}_${DateTime.now().millisecondsSinceEpoch.toString()}.$suffix';
    FormData formData = FormData.fromMap({
      "mode": uploadOriginalName ? "original" : null,
      "fileName": setFileName ?? fileName,
      "type": fileType,
      "file": await MultipartFile.fromFile(path,
          filename: name,
          contentType:
              MediaType.parse("image/${suffix == 'jpg' ? 'jpeg' : suffix}"))
    });
    return formData;
  }

  /// upload avatar data
  // formDataAvatar() async {
  //   String path = file.path;
  //   var name = path.substring(path.lastIndexOf("/") + 1, path.length);
  //   var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
  //   fileName = '${GlobalData.userMemberId}.$suffix';
  //   FormData formData = FormData.fromMap({
  //     "fileName": fileName,
  //     "fileType": fileType,
  //     "folder": folder,
  //     "file": await MultipartFile.fromFile(path,
  //         filename: name, contentType: MediaType.parse("image/$suffix"))
  //   });
  //   return formData;
  // }

  formDataVideo() async {
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    fileName =
        '${GlobalData.userMemberId}_${DateTime.now().millisecondsSinceEpoch.toString()}_${Random().nextInt(899) + 100}.$suffix';
    FormData formData = FormData.fromMap({
      "mode": uploadOriginalName ? "original" : null,
      "fileName": fileName,
      "fileType": fileType,
      "file": await MultipartFile.fromFile(path,
          filename: name, contentType: MediaType.parse("video/$suffix"))
    });
    return formData;
  }
}
