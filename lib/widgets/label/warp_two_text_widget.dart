import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/theme/app_colors.dart';

class WarpTwoTextWidget extends StatelessWidget {
  const WarpTwoTextWidget(
      {Key? key,
      required this.text,
      this.fontSize,
      this.maxLines = 2,
      this.color = AppColors.dialogBlack,
      this.fontWeight = FontWeight.w400,
      this.textAlign = TextAlign.start,
      this.warpAlignment = WrapAlignment.start,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final WrapAlignment warpAlignment;
  final TextOverflow overflow;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Wrap(alignment: warpAlignment, children: [
      Text(text,
          overflow: overflow,
          maxLines: maxLines,
          textAlign: textAlign,
          style: TextStyle(
              fontSize: fontSize ?? UIDefine.fontSize12,
              fontWeight: fontWeight,
              color: color))
    ]);
  }
}
