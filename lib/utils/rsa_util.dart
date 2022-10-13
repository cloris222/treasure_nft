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
    dynamic publicKey = RSAKeyParser().parse(splitStr(HttpSetting.developKey));
    final encrypt = Encrypter(RSA(publicKey: publicKey));
    return encrypt.encrypt(encoded).base64;
  }

  static Future<String> decodeString(String content) async {
    dynamic publicKey = RSAKeyParser().parse(splitStr(HttpSetting.developKey));
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.decrypt(Encrypted.fromBase64(content));
  }
}
