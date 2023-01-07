import 'dart:ui';
import '../constant/theme/app_colors.dart';

import '../constant/enum/style_enum.dart';

class CustomTextStyle {
  TextStyle getBaseStyle(
      {Color color = AppColors.textBlack,
      double? fontSize,
      FontWeight? fontWeight,
      CustomTextFamily fontFamily = CustomTextFamily.PosteramaText}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily.name,
        fontWeight: fontWeight != null
            ? (fontWeight.index > FontWeight.w500.index
                ? FontWeight.w500
                : fontWeight)
            : null);
  }
}
