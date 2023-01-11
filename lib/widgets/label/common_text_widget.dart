import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';

import '../../constant/theme/app_colors.dart';

class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget(
      {Key? key,
      required this.text,
      this.alignment,
      this.margin = const EdgeInsets.symmetric(vertical: 10),
      this.onPress,
      this.fillWidth = true,
      this.fontSize,
      this.fontWeight = FontWeight.w600})
      : super(key: key);
  final String text;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onPress;
  final bool fillWidth;
  final double? fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    bool isConnectText = (onPress != null);
    return InkWell(
      onTap: () {
        if (isConnectText) {
          onPress!();
        }
      },
      child: Container(
        alignment: alignment,
        margin: margin,
        width: fillWidth ? UIDefine.getWidth() : null,
        child: isConnectText
            ? GradientThirdText(text,
                size: fontSize ?? UIDefine.fontSize14, weight: fontWeight)
            : Text(
                text,
                style: AppTextStyle.getBaseStyle(
                    fontSize: fontSize ?? UIDefine.fontSize14,
                    fontWeight: fontWeight,
                    color: isConnectText
                        ? AppColors.mainThemeButton
                        : AppColors.textBlack),
              ),
      ),
    );
  }
}
