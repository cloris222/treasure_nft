import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/theme/app_colors.dart';
import '../gradient_text.dart';

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
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: AppStyle().baseGradient(radius: 10),
              width: width ?? UIDefine.getWidth(),
              height: height ?? 50,
              child: const Text('')),
          Positioned(
            top: 12,
            bottom: 12,
            left: 2,
            right: 2,
            child: Container(
                alignment: Alignment.center,
                decoration: AppStyle().styleColorsRadiusBackground(
                    color: Colors.white, radius: 10),
                child: GradientText(btnText,
                    size: UIDefine.fontSize16,
                    starColor: AppColors.mainThemeButton,
                    endColor: AppColors.subThemePurple)),
          ),
        ],
      ),
    );
  }
}
