
import 'package:flutter/material.dart';

class GlobalData {
  GlobalData._();
  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static bool firstLaunch = true;
}
