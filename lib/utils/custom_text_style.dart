import 'package:flutter/material.dart';

import '../constant/theme/app_colors.dart';

import '../constant/enum/style_enum.dart';

class CustomTextStyle {
  const CustomTextStyle._();

  static TextStyle getBaseStyle(
      {Color color = AppColors.textBlack,
      double? fontSize,
      FontWeight? fontWeight,
      CustomTextFamily fontFamily = CustomTextFamily.PosteramaText,
      FontStyle? fontStyle,
      double? height}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily.name,
        fontWeight: fontWeight != null
            ? (fontWeight.index > FontWeight.w500.index
                ? FontWeight.w500
                : fontWeight)
            : null,
        fontStyle: fontStyle,
        height: height);
  }
}
