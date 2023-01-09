import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';

class IconTextButtonWidget extends StatelessWidget {
  const IconTextButtonWidget({super.key,
  required this.btnText,
  required this.iconPath,
  required this.onPressed,
  this.width,
  this.enable = true,
  this.height,
  this.fontSize,
  this.fontWeight
  });

  final String btnText;
  final String iconPath;
  final VoidCallback onPressed;
  final bool enable;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: UIDefine.getScreenWidth(2), horizontal: UIDefine.getScreenWidth(5)),
          decoration: enable
              ? AppStyle().baseGradient(radius: 10)
              : AppStyle()
              .styleColorsRadiusBackground(color: AppColors.buttonGrey),
          width: width ?? UIDefine.getWidth(),
          height: height ?? 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(iconPath),
              const SizedBox(width: 4),
              Text(btnText,
                  style: AppTextStyle.getBaseStyle(
                      color: Colors.white,
                      fontSize: fontSize ?? UIDefine.fontSize16,
                      fontWeight: fontWeight ))
            ],
          )
      ),
    );
  }

}