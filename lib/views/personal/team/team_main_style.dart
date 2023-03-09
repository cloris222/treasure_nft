import 'package:flutter/material.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/ui_define.dart';

class TeamMainStyle{
  Widget getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }

  Widget getPaddingWithView(double val, Widget view) {
    return Padding(
      padding: EdgeInsets.only(
        top: UIDefine.getScreenWidth(val),
        bottom: UIDefine.getScreenWidth(val),
      ),
      child: view,
    );
  }

  BoxDecoration setBoxDecoration() {
    return BoxDecoration(
        border: Border.all(width: 1, color: AppColors.bolderGrey),
        borderRadius: BorderRadius.circular(8));
  }

  OutlineInputBorder setOutlineInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.bolderGrey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8)));
  }
}