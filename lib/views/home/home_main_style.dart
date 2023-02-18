import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/enum/style_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../utils/app_text_style.dart';

class HomeMainStyle{
  ///Widget Style----------
  Widget buildSpace({double width = 0, double height = 0}) {
    return SizedBox(
        height: UIDefine.getPixelWidth(height * 5),
        width: UIDefine.getPixelWidth(width * 5));
  }

  ///MARK: 共用的左右間距
  EdgeInsetsGeometry getMainPadding({double width = 20, double height = 0}) {
    return EdgeInsets.symmetric(
        horizontal: UIDefine.getPixelWidth(width),
        vertical: UIDefine.getPixelWidth(height));
  }
  Widget getPadding(double val) {
    return Padding(padding: EdgeInsets.all(UIDefine.getScreenWidth(val)));
  }

  ///MARK: 主標題
  TextStyle getMainTitleStyle(
      {AppTextFamily family = AppTextFamily.PosteramaText}) {
    return AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize24,
        fontWeight: FontWeight.w900,
        color: AppColors.textBlack,
        fontFamily: family);
  }

  ///MARK: 副標題
  TextStyle getSubTitleStyle() {
    return AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize20,
        fontWeight: FontWeight.w600,
        color: AppColors.textBlack,
        fontFamily: AppTextFamily.PosteramaText);
  }

  ///MARK: 內容
  TextStyle getContextStyle(
      {Color color = AppColors.textBlack,
        FontWeight fontWeight = FontWeight.w400,
        double? fontSize}) {
    return AppTextStyle.getBaseStyle(
        fontSize: fontSize ?? UIDefine.fontSize14,
        fontWeight: fontWeight,
        color: color);
  }

}