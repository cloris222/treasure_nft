import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/theme/app_colors.dart';
import '../gradient_text.dart';
import '../label/gradient_bolder_widget.dart';

class LoginBolderButtonWidget extends StatelessWidget {
  const LoginBolderButtonWidget(
      {Key? key,
      required this.btnText,
      required this.onPressed,
      this.width,
      this.height,
      this.radius = 10,
      this.textSize,
      this.fontWeight})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double radius;
  final double? textSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: GradientBolderWidget(
            radius: radius,
            width: width,
            height: height,
            child: GradientText(btnText,
                size: textSize ?? UIDefine.fontSize16,
                weight: fontWeight ?? FontWeight.w400,
                colors: AppColors.gradientBaseColorBg)));
  }
}
