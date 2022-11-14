import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageListSharedPreferences {
  static const String imageKey = "IMAGE_KEY";

  static Future<List<String>?> getImagesFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(imageKey);
  }

  static Future<bool> saveImageToPreferences(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? currentImages = prefs.getStringList(imageKey); // getting current loaded images
    currentImages?.add(value);  // adding the new image
    return prefs.setStringList(imageKey, currentImages!); // saving the array of images
  }

  static Future<bool> resetImages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(imageKey, []); // deleting all saved images
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}