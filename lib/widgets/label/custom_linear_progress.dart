import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/theme/app_colors.dart';

class CustomLinearProgress extends StatelessWidget {
  const CustomLinearProgress(
      {Key? key,
      required this.percentage,
      this.backgroundColor = AppColors.transParentHalf,
      this.valueColor = AppColors.mainThemeButton,
      this.height = 20,
      this.radius = 15})
      : super(key: key);
  final double percentage;
  final Color backgroundColor;
  final Color valueColor;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.centerLeft, children: [
      Container(
          decoration: AppStyle().styleColorsRadiusBackground(
              color: backgroundColor, radius: radius),
          width: UIDefine.getWidth(),
          height: height),
      Container(
          decoration: AppStyle()
              .styleColorsRadiusBackground(color: valueColor, radius: radius),
          width: UIDefine.getWidth() * percentage,
          height: height)
    ]);
  }
}
