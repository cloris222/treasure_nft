import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget(
      {Key? key,
      required this.btnText,
      required this.onPressed,
      this.width,
      this.enable = true,
      this.height,
      this.fontSize,
      this.fontWeight,
      this.isGradient = true,
      this.isFlip = false,
      this.radius = 10,
      this.showIcon = false,
      this.isFillWidth = true,
      this.margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      this.padding,
      this.fontFamily = AppTextFamily.PosteramaText})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final bool enable;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool isGradient;
  final bool isFlip;
  final double radius;
  final bool showIcon;
  final bool isFillWidth;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? padding;
  final AppTextFamily fontFamily;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          alignment: Alignment.center,
          margin: margin,
          padding: padding ??
              EdgeInsets.symmetric(
                  horizontal: UIDefine.getPixelWidth(10),
                  vertical: UIDefine.getPixelWidth(5)),
          decoration: enable
              ? isGradient
                  ? isFlip
                      ? AppStyle().baseFlipGradient(radius: radius)
                      : AppStyle().baseGradient(radius: radius)
                  : AppStyle().styleColorsRadiusBackground(
                      color: AppColors.mainThemeButton)
              : isGradient
                  ? AppStyle().buildGradient(
                      radius: radius,
                      colors: AppColors.gradientBackgroundColorBg)
                  : AppStyle()
                      .styleColorsRadiusBackground(color: AppColors.buttonGrey),
          width: width ?? (isFillWidth ? UIDefine.getWidth() : null),
          height: height ?? 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: isFillWidth ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Visibility(
                  visible: showIcon,
                  child: Icon(
                    Icons.storefront,
                    color: Colors.white,
                    size: UIDefine.fontSize18,
                  )),
              Visibility(
                  visible: showIcon,
                  child: SizedBox(
                    width: UIDefine.getPixelWidth(5),
                  )),
              Text(btnText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.getBaseStyle(
                      color: Colors.white,
                      fontSize: fontSize ?? UIDefine.fontSize16,
                      fontWeight: fontWeight,
                      fontFamily: fontFamily)),
            ],
          )),
    );
  }
}
