import 'package:treasure_nft_project/models/http/http_setting.dart';

///伺服器線路
enum RouteSetting {
  /// 原本用的伺服器
  lineXyz(debugDomain: "dev.treasurenft.xyz", releaseDomain: "treasurenft.xyz"),

  /// 備用伺服器
  lineWord(debugDomain: "dev.treasurenft.xyz", releaseDomain: "treasurenft.world");

  final String debugDomain;
  final String releaseDomain;

  const RouteSetting({required this.debugDomain, required this.releaseDomain});

  String getDomain() {
    return HttpSetting.debugMode ? debugDomain : releaseDomain;
  }
}
