import 'package:treasure_nft_project/models/http/http_setting.dart';

///伺服器線路
enum ServerRoute {
  /// 原本用的伺服器
  routeXyz(debugDomain: "dev.treasurenft.xyz", releaseDomain: "treasurenft.xyz"),

  /// 備用伺服器
  routeWorld(debugDomain: "dev.treasurenft.xyz", releaseDomain: "a.treasurenft.world");

  final String debugDomain;
  final String releaseDomain;

  const ServerRoute({required this.debugDomain, required this.releaseDomain});

  String getDomain() {
    return HttpSetting.debugMode ? debugDomain : releaseDomain;
  }

  String getFullUrl() {
    return "https://${getDomain()}/";
  }
}
