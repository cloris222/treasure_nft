import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../constant/theme/app_colors.dart';

import '../constant/enum/style_enum.dart';

class AppTextStyle {
  const AppTextStyle._();

  static bool isSystemBold() {
    bool isSystemBold =
        MediaQuery.of(BaseViewModel().getGlobalContext()).boldText;
    GlobalData.printLog('isSystemBold:$isSystemBold');
    return isSystemBold;
  }

  static TextStyle getBaseStyle(
      {Color color = AppColors.textBlack,
      double? fontSize,
      FontWeight? fontWeight,
      AppTextFamily fontFamily = AppTextFamily.PosteramaText,
      FontStyle? fontStyle,
      double? height}) {
    return TextStyle(
        color: color,
        fontSize: fontSize ?? UIDefine.fontSize12,
        fontFamily: fontFamily.name,
        fontWeight: fontWeight != null

            ///MARK: 在release mode才加判斷
            ? (fontWeight.index > FontWeight.w500.index && isSystemBold()
                ? FontWeight.w500
                : fontWeight)
            : null,
        fontStyle: fontStyle,
        height: height);
  }
}
