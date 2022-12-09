import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

///MARK: 圖檔壓縮
class ImageCompressUtil {
  /// File -> File
  Future<File?> imageCompressAndGetFile(File file) async {
    if (file.lengthSync() < 200 * 1024) {
      return file;
    }
    var quality = 100;
    if (file.lengthSync() > 4 * 1024 * 1024) {
      quality = 50;
    } else if (file.lengthSync() > 2 * 1024 * 1024) {
      quality = 60;
    } else if (file.lengthSync() > 1 * 1024 * 1024) {
      quality = 70;
    } else if (file.lengthSync() > 0.5 * 1024 * 1024) {
      quality = 80;
    } else if (file.lengthSync() > 0.25 * 1024 * 1024) {
      quality = 90;
    }

    String fileName = file.path.split('/').last; // image_01.png
    String name = fileName.split('.').first; // image_01
    String suffix = fileName.split('.').last; // png , jpg , jpeg

    var dir = await path_provider.getTemporaryDirectory();
    var targetPath = dir.absolute.path + "/" + name + "_compre." + suffix;

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 600,
      quality: quality,
      rotate: 0,
    );

    debugPrint("壓縮前Size：${file.lengthSync() / 1024}");
    debugPrint("壓縮後Size：${(result?.lengthSync())! / 1024}");

    return result;
  }

  /// File -> Uint8List
  Future<Uint8List?> imageCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    debugPrint(file.lengthSync().toString());
    debugPrint(result?.length.toString());
    return result;
  }

  /// Asset -> Uint8List
  Future<Uint8List?> imageCompressAsset(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );

    return list;
  }

  /// Uint8List -> Uint8List
  Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    debugPrint(list.length.toString());
    debugPrint(result.length.toString());
    return result;
  }
}