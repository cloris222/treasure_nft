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
      this.height})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: GradientBolderWidget(
          width: width,
            height: height,
            child: GradientText(btnText,
                size: UIDefine.fontSize16,
                starColor: AppColors.mainThemeButton,
                endColor: AppColors.subThemePurple)));
  }
}
