import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';

import '../../constant/ui_define.dart';
import 'action_button_widget.dart';

class GradientTextButton extends ActionButtonWidget {
  const GradientTextButton({super.key,
    required super.btnText,
    required super.onPressed,
    super.fontSize,
    super.margin,
    super.padding,
    super.isBorderStyle,
    super.isFillWidth = false,
    super.radius = 5,
    super.fontWeight,
    super.setHeight,
    this.backgroundHorizontal,
    this.backgroundVertical,
    this.textAlign});

  final double? backgroundVertical;
  final double? backgroundHorizontal;
  final TextAlign? textAlign;

  @override
  Widget createButton(BuildContext context) {
    Color primaryColor, borderColor, textColor;
    if (isBorderStyle) {
      primaryColor = setSubColor;
      borderColor = setMainColor;
      textColor = setMainColor;
    } else {
      primaryColor = setMainColor;
      borderColor = setTransColor;
      textColor = setSubColor;
    }
    var actionButton = InkWell(
        onTap: () => onPressed(),
        child: Container(
            padding: EdgeInsets.symmetric(
                vertical: backgroundVertical ?? UIDefine.getPixelHeight(5),
                horizontal: backgroundHorizontal ?? UIDefine.getPixelWidth(10)),
            decoration: AppStyle().styleColorBorderBackground(
                radius: radius,
                color: borderColor,
                backgroundColor: primaryColor),
            child: Text(
              btnText,
              textAlign: textAlign,
              style: TextStyle(
                  fontWeight: fontWeight,
                  color: textColor, fontSize: fontSize ?? UIDefine.fontSize16),
            )));

    return isFillWidth
        ? Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: margin,
        padding: padding,
        child: actionButton)
        : Container(margin: margin, padding: padding, child: actionButton);
  }
}
