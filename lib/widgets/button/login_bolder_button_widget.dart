import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';

class LoginBolderButtonWidget extends StatelessWidget {
  const LoginBolderButtonWidget(
      {Key? key,
      required this.btnText,
      required this.onPressed,
      this.width,
      this.height,
      this.radius = 10,
      this.fontSize,
      this.fontWeight,
      this.isFillWidth = true,
      this.margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      this.padding})
      : super(key: key);
  final String btnText;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry margin;
  final bool isFillWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: AppColors.gradientBaseColorBg)
              .createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Container(
              alignment: Alignment.center,
              decoration: AppStyle().styleColorBorderBackground(
                  color: Colors.grey,
                  backgroundColor: Colors.transparent,
                  radius: radius),
              width: width ?? (isFillWidth ? UIDefine.getWidth() : null),
              height: height ?? 50,
              margin: margin,
              padding: padding ??
                  EdgeInsets.symmetric(
                      horizontal: UIDefine.getPixelWidth(10),
                      vertical: UIDefine.getPixelWidth(5)),
              child: Text(btnText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: fontSize ?? UIDefine.fontSize20,
                      fontWeight: fontWeight ?? FontWeight.w400))),
        ));
  }
}
