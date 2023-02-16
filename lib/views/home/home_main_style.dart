import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

class HomeMainStyle{
  ///Widget Style----------
  Widget buildSpace({double width = 0, double height = 0}) {
    return SizedBox(
        height: UIDefine.getPixelWidth(height * 5),
        width: UIDefine.getPixelWidth(width * 5));
  }
}