import 'package:flutter/material.dart';

import '../widgets/app_bottom_navigation_bar.dart';

class GlobalData {
  GlobalData._();

  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static bool firstLaunch = true;

  ///MARK: 控管bar的圖案顯示
  static AppNavigationBarType mainBottomType = AppNavigationBarType.typeNull;
}
