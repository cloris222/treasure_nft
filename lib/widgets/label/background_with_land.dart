import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';

import '../../constant/ui_define.dart';

class BackgroundWithLand extends StatelessWidget {
  const BackgroundWithLand(
      {Key? key,
      required this.body,
      this.mainHeight = 300,
      this.bottomHeight = 70,
      required this.onBackPress,
      this.backgroundColor = AppColors.defaultBackgroundSpace,
      this.showPreBtn = true,
      })
      : super(key: key);
  final Widget body;
  final double mainHeight;
  final double bottomHeight;
  final onClickFunction onBackPress;
  final Color backgroundColor;
  final bool showPreBtn;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            height: UIDefine.getPixelWidth(mainHeight),
            width: UIDefine.getWidth(),
            child: Image.asset(AppImagePath.backgroundLand, fit: BoxFit.cover)),
        Positioned(
            top: UIDefine.getPixelWidth(mainHeight - bottomHeight),
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                decoration: AppStyle().styleColorsRadiusBackground(
                    hasBottomLef: false,
                    hasBottomRight: false,
                    color: backgroundColor,
                    radius: 12))),
        Positioned(
            top: UIDefine.getPixelWidth(12),
            left: UIDefine.getPixelWidth(10),
            child: showPreBtn?_buildPreButton():const SizedBox()),
        Positioned(
            top: UIDefine.getPixelWidth(showPreBtn ? 50 : 20),
            bottom: 0,
            left: 0,
            right: 0,
            child: body),
      ],
    );
  }

  Widget _buildPreButton() {
    return GestureDetector(
      onTap: onBackPress,
      child: Image.asset(
        AppImagePath.arrowLeftBlack,
        height: UIDefine.getPixelWidth(24),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
