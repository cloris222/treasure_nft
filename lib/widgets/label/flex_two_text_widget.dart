import 'package:flutter/material.dart';

import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';

///MARK: 用於最多兩行的Widget
class FlexTwoTextWidget extends StatelessWidget {
  const FlexTwoTextWidget({
    Key? key,
    this.fontSize = 12,
    required this.text,
    this.color = AppColors.dialogBlack,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
    this.alignment = Alignment.topCenter,
  }) : super(key: key);
  final int fontSize;
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        width: UIDefine.getWidth(),
        height: getFontSize(fontSize + 2) * 2.7,
        child: Text(text,
            softWrap: true,
            textAlign: textAlign,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.getBaseStyle(
                fontSize: getFontSize(fontSize),
                color: color,
                fontWeight: fontWeight)));
  }

  double getFontSize(int size) {
    switch (size) {
      case 36:
        return UIDefine.fontSize36;
      case 34:
        return UIDefine.fontSize34;
      case 32:
        return UIDefine.fontSize32;
      case 30:
        return UIDefine.fontSize30;
      case 28:
        return UIDefine.fontSize28;
      case 26:
        return UIDefine.fontSize26;
      case 24:
        return UIDefine.fontSize24;
      case 22:
        return UIDefine.fontSize22;
      case 20:
        return UIDefine.fontSize20;
      case 18:
        return UIDefine.fontSize18;
      case 16:
        return UIDefine.fontSize16;
      case 14:
        return UIDefine.fontSize14;
      case 12:
        return UIDefine.fontSize12;
      case 10:
        return UIDefine.fontSize10;
      case 8:
        return UIDefine.fontSize8;

      default:
        return UIDefine.fontSize36;
    }
  }
}
