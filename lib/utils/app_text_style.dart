import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';

import '../constant/theme/app_colors.dart';

import '../constant/enum/style_enum.dart';

class AppTextStyle {
  const AppTextStyle._();

  static TextStyle getBaseStyle(
      {Color color = AppColors.textBlack,
      double? fontSize,
      FontWeight? fontWeight,
      AppTextFamily fontFamily = AppTextFamily.PosteramaText,
      FontStyle? fontStyle,
      double? height}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily.name,
        fontWeight: fontWeight != null

            ///MARK: 在release mode才加判斷
            ? (fontWeight.index > FontWeight.w500.index &&
                    !GlobalData.isDebugMode()
                ? FontWeight.w500
                : fontWeight)
            : null,
        fontStyle: fontStyle,
        height: height);
  }
}
