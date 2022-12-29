import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

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
      this.margin = const EdgeInsets.symmetric(vertical: 10),
      this.padding})
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          alignment: Alignment.center,
          margin: margin,
          padding: padding,
          decoration: enable
              ? isGradient
                  ? isFlip
                      ? AppStyle().baseFlipGradient(radius: radius)
                      : AppStyle().baseGradient(radius: radius)
                  : AppStyle().styleColorsRadiusBackground(
                      color: AppColors.mainThemeButton)
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
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize ?? UIDefine.fontSize16,
                      fontWeight: fontWeight)),
            ],
          )),
    );
  }
}
