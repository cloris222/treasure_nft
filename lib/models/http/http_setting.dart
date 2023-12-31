class HttpSetting {
  HttpSetting._();

  ///MARK: 連接的線路控管
  static const String appUrl = "https://{route}/gateway/app";
  static const String commonUrl = "https://{route}/gateway/common";
  static const String adminUrl = "https://{route}/gateway/admin";
  static const String shareOther = 'https://{route}/#/otherCol?orderNo={orderNo}&type={type}';

  static const String socketUrl = 'https://{route}/gateway/websocket/websocket-connect';

  ///MARK: Release Setting
  static const String imgUrl = "https://image.treasurenft.xyz";
  static const String postKey =
      "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPPrcA1ZO5YmIPDqq/fBp6wQl3y1sAuVQhiTFmVLuUTh2euLZVFE2QzPLmY+9J+uxdLJrvXKWgQA8z5rC8TJrd41jxWdADH8D931UHm50lmZJcA8JEpTNEnXUkX5aR8kJWcy59ogGsE/cCu2+xzfkQOu9urc12dyw1zaPDVqQRSwIDAQAB";
  static const String homeAdUrl =
      'https://image.treasurenft.xyz/Treasure2.5/index/pc_ad_01.mp4';
  static const String systemTimeZone='GMT+4';
  static const String pcArtistUrl =
      'https://image.treasurenft.xyz/video/index_video_{lang}.mp4';
  static const bool debugMode = false;
  static const bool printDebugLog = false;

  ///MARK: develop Setting
  // static const String imgUrl = "https://devimage.treasurenft.xyz";
  // static const String postKey =
  //     "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPPrcA1ZO5YmIPDqq/fBp6wQl3y1sAuVQhiTFmVLuUTh2euLZVFE2QzPLmY+9J+uxdLJrvXKWgQA8z5rC8TJrd41jxWdADH8D931UHm50lmZJcA8JEpTNEnXUkX5aR8kJWcy59ogGsE/cCu2+xzfkQOu9urc12dyw1zaPDVqQRSwIDAQAB";
  // static const String homeAdUrl = 'https://devimage.treasurenft.xyz/video/index_video_{lang}.mp4';
  // static const String systemTimeZone = 'GMT+8';
  // static const String pcArtistUrl = 'https://dev.treasurenft.xyz/#/userMap/exploreCreator?id={artistId}';
  //
  // static const bool debugMode = true;
  // static const bool printDebugLog = true;

  // receiveTimeout
  static const int receiveTimeout = 180000;

  // connectTimeout
  static const int connectionTimeout = 180000;
}
