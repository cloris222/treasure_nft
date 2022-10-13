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
      this.enable = true, this.height,this.fontSize})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final bool enable;
  final double? width;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: enable
              ? AppStyle().baseGradient(radius: 10)
              : AppStyle()
                  .styleColorsRadiusBackground(color: AppColors.buttonGrey),
          width: width ?? UIDefine.getWidth(),
          height: height ?? 50,
          child: Text(btnText,
              style: TextStyle(
                  color: Colors.white, fontSize: fontSize ?? UIDefine.fontSize16))),
    );
  }
}
