import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/theme/app_colors.dart';

class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget({
    Key? key,
    required this.text,
    this.alignment,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    this.onPress,
    this.fillWidth = true,
  }) : super(key: key);
  final String text;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onPress;
  final bool fillWidth;

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
        child: Text(
          text,
          style: TextStyle(
              color: isConnectText
                  ? AppColors.mainThemeButton
                  : AppColors.textBlack),
        ),
      ),
    );
  }
}
