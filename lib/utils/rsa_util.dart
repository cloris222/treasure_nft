import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:treasure_nft_project/models/http/http_setting.dart';

//MARK: RSA 加密
class RSAEncode {
  static splitStr(String str) {
    var begin = '-----BEGIN PUBLIC KEY-----\n';
    var end = '\n-----END PUBLIC KEY-----';
    int splitCount = str.length ~/ 64;
    List<String> strList = [];

    for (int i = 0; i < splitCount; i++) {
      strList.add(str.substring(64 * i, 64 * (i + 1)));
    }
    if (str.length % 64 != 0) {
      strList.add(str.substring(64 * splitCount));
    }
    return begin + strList.join('\n') + end;
  }

  static Future<String> encodeString(Map<String, String> content) async {
    String encoded = base64.encode(utf8.encode(jsonEncode(content)));
    dynamic publicKey = RSAKeyParser().parse(splitStr(HttpSetting.postKey));
    final encrypt = Encrypter(RSA(publicKey: publicKey));
    return encrypt.encrypt(encoded).base64;
  }

  /// MARK: JSON 长参数分段加密
  static Future<String> encodeLong(Map para) async {
    // 设置加密对象
    dynamic publicKey = RSAKeyParser().parse(splitStr(HttpSetting.postKey));
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    // map转成json字符串
    final jsonStr = base64.encode(utf8.encode(jsonEncode(para)));
    // 原始json转成字节数组
    List<int> sourceByts = utf8.encode(jsonStr);
    // 数据长度
    int inputLen = sourceByts.length;
    // 加密最大长度
    int maxLen = 117;
    // 存放加密后的字节数组
    List<int> totalByts = [];
    // 分段加密 步长为117
    for (var i = 0; i < inputLen; i += maxLen) {
      // 还剩多少字节长度
      int endLen = inputLen - i;
      List<int> item;
      if (endLen > maxLen) {
        item = sourceByts.sublist(i, i + maxLen);
      } else {
        item = sourceByts.sublist(i, i + endLen);
      }
      // 加密后的对象转换成字节数组再存放到容器
      totalByts.addAll(encrypter.encryptBytes(item).bytes);
    }
    // 加密后的字节数组转换成base64编码并返回
    String en = base64.encode(totalByts);
    return en;
  }

  static Future<String> decodeString(String content) async {
    dynamic publicKey = RSAKeyParser().parse(splitStr(HttpSetting.postKey));
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.decrypt(Encrypted.fromBase64(content));
  }
}
