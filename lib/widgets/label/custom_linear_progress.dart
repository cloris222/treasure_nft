import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../utils/number_format_util.dart';
import 'icon/base_icon_widget.dart';

class CustomLinearProgress extends StatelessWidget {
  const CustomLinearProgress(
      {Key? key,
      required this.percentage,
      this.backgroundColor = AppColors.transParentHalf,
      this.valueColor = AppColors.mainThemeButton,
      this.height = 4,
      this.radius = 15,
      this.needShowPercentage = false,
      this.needShowFinishIcon = true,
      this.needGradientValue = true})
      : super(key: key);
  final double percentage;
  final Color backgroundColor;
  final Color valueColor;
  final double? height;
  final double radius;
  final bool needShowPercentage;
  final bool needShowFinishIcon;
  final bool needGradientValue;

  @override
  Widget build(BuildContext context) {
    int flex;

    ///MARK:避免數值為 1/0 or 0/1
    if (percentage.isNaN || percentage == double.infinity) {
      flex = 100;
    } else {
      flex = int.parse(NumberFormatUtil()
          .integerFormat(percentage * 100, hasSeparator: false));
    }
    if (flex <= 0) {
      flex = 0;
    }
    if (flex >= 100) {
      flex = 100;
    }
    return Row(
      children: [
        Flexible(
            child: Stack(alignment: Alignment.centerLeft, children: [
          Container(
              decoration: AppStyle().styleColorsRadiusBackground(
                  color: backgroundColor, radius: radius),
              width: UIDefine.getWidth(),
              height: height),
          Row(
            children: [
              flex == 0
                  ? Container()
                  : Flexible(
                      flex: flex,
                      child: Container(
                          decoration: needGradientValue
                              ? AppStyle().baseGradient(radius: radius)
                              : AppStyle().styleColorsRadiusBackground(
                                  color: valueColor, radius: radius),
                          width: UIDefine.getWidth(),
                          height: height),
                    ),
              flex == 100
                  ? Container()
                  : Flexible(
                      flex: 100 - flex,
                      child: Container(width: UIDefine.getWidth())),
            ],
          )
        ])),
        Visibility(
            visible: needShowPercentage,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: (flex == 100 && needShowFinishIcon)
                  ? BaseIconWidget(
                      imageAssetPath: AppImagePath.blueCheckIcon,
                      size: UIDefine.fontSize16)
                  : Text(
                      '$flex%',
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize12),
                    ),
            ))
      ],
    );
  }
}
