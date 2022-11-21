class HttpSetting {
  HttpSetting._();

  ///MARK: Release Setting
  // static const String appUrl = "https://treasurenft.xyz/gateway/app";
  // static const String commonUrl = "https://treasurenft.xyz/gateway/common";
  // static const String adminUrl = "https://treasurenft.xyz/gateway/admin";
  // static const String postKey =
  //     "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPPrcA1ZO5YmIPDqq/fBp6wQl3y1sAuVQhiTFmVLuUTh2euLZVFE2QzPLmY+9J+uxdLJrvXKWgQA8z5rC8TJrd41jxWdADH8D931UHm50lmZJcA8JEpTNEnXUkX5aR8kJWcy59ogGsE/cCu2+xzfkQOu9urc12dyw1zaPDVqQRSwIDAQAB";
  // static const String socketUrl =
  //     'https://treasurenft.xyz/gateway/websocket/websocket-connect';
  // static const String homeAdUrl =
  //     'https://image.treasurenft.xyz/Treasure2.5/index/pc_ad_01.mp4';
  // static const String systemTimeZone='GMT+4';

  ///MARK: develop Setting
  static const String appUrl = "https://dev.treasurenft.xyz/gateway/app";
  static const String commonUrl = "https://dev.treasurenft.xyz/gateway/common";
  static const String adminUrl = "https://dev.treasurenft.xyz/gateway/admin";
  static const String postKey =
      "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPPrcA1ZO5YmIPDqq/fBp6wQl3y1sAuVQhiTFmVLuUTh2euLZVFE2QzPLmY+9J+uxdLJrvXKWgQA8z5rC8TJrd41jxWdADH8D931UHm50lmZJcA8JEpTNEnXUkX5aR8kJWcy59ogGsE/cCu2+xzfkQOu9urc12dyw1zaPDVqQRSwIDAQAB";
  static const String socketUrl =
      'https://dev.treasurenft.xyz/gateway/websocket/websocket-connect';
  static const String homeAdUrl =
      'https://devimage.treasurenft.xyz/Treasure2.5/index/pc_ad_01.mp4';
  static const String systemTimeZone = 'GMT+8';

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
