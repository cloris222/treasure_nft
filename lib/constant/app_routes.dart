import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

import '../views/airdrop/airdrop_main_page.dart';
import '../views/internal_message/internal_message_main_page.dart';

@immutable //不可變物件
class AppRoutes {
  const AppRoutes._();

  static Map<String, WidgetBuilder> define() {
    return {
      "/AirdropMain": (context) => const AirdropMainPage(),
      "/InternalMessage": (context) => const InternalMessageMainPage(),
    };
  }

  static _checkRoutePath(BuildContext context, String routePath) {
    String? path = ModalRoute.of(context)?.settings.name;
    GlobalData.printLog("_checkRoutePath:$path");
    if (path != null) {
      /// 路徑相同時，不跳轉
      if (routePath.compareTo(path) == 0) {
        return;
      }
    }
    Navigator.pushNamed(context, routePath);
  }

  ///推到寶箱首頁
  static pushAirdrop(BuildContext context) {
    _checkRoutePath(context, "/AirdropMain");
  }

  ///推到站內信首頁
  static pushInternalMessage(BuildContext context) {
    _checkRoutePath(context, "/InternalMessage");
  }
}
