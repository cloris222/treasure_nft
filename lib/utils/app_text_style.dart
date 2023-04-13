import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../constant/theme/app_colors.dart';

import '../constant/enum/style_enum.dart';

class AppTextStyle {
  const AppTextStyle._();

  static bool isSystemBold() {
    return MediaQuery.of(BaseViewModel().getGlobalContext()).boldText;
  }

  static FontWeight? getFontWeight(FontWeight? fontWeight) {
    if (fontWeight == null) {
      return null;
    }
    if (isSystemBold()) {
      if (fontWeight.index <= FontWeight.w500.index) {
        return null;
      }
    }
    return fontWeight;
  }

  static TextStyle getBaseStyle(
      {Color color = AppColors.textBlack,
      double? fontSize,
      FontWeight? fontWeight,
      AppTextFamily fontFamily = AppTextFamily.PosteramaText,
      FontStyle? fontStyle,
      double? height,
      TextDecoration? textDecoration}) {
    return TextStyle(
      color: color,
      fontSize: fontSize ?? UIDefine.fontSize12,
      fontFamily: fontFamily.name,
      fontWeight: getFontWeight(fontWeight),
      fontStyle: fontStyle,
      height: height,
      decoration: textDecoration,
    );
  }
}
