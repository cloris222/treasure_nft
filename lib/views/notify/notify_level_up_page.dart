import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import 'package:treasure_nft_project/widgets/label/icon/level_icon_widget.dart';

import '../../constant/theme/app_animation_path.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/gradient_text.dart';

class NotifyLevelUpPage extends StatelessWidget {
  NotifyLevelUpPage({Key? key, required this.oldLevel, required this.newLevel})
      : super(key: key);
  final int oldLevel;
  final int newLevel;
  final double pageHeight = UIDefine.getHeight() * 0.8;

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(padding),
            child: Stack(alignment: Alignment.center, children: [
              Container(
                decoration: AppStyle().styleColorsRadiusBackground(),
                width: UIDefine.getWidth(),
                height: pageHeight,
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Lottie.asset(AppAnimationPath.showLevelUp,
                      fit: BoxFit.fill)),
              Positioned(
                  top: pageHeight * 0.4,
                  child: LevelIconWidget(
                      level: newLevel, size: pageHeight * 0.25)),
              Positioned(
                  top: pageHeight * 0.70,
                  left: UIDefine.getScreenWidth(10),
                  right: UIDefine.getScreenWidth(10),
                  child: _buildLevel()),
              Positioned(
                  bottom: 2,
                  child: LoginButtonWidget(
                    isFlip: true,
                    width: UIDefine.getScreenWidth(40),
                    btnText: tr('OK'),
                    onPressed: () => {BaseViewModel().popPage(context)},
                  ))
            ])));
  }

  Widget _buildLevel() {
    var space = const SizedBox(width: 5);
    var levelHeight = pageHeight * 0.07;
    var lvText =
        GradientText('LV', weight: FontWeight.w500, size: levelHeight * 0.5);
    var levelStyle = AppTextStyle.getBaseStyle(
        fontWeight: FontWeight.w500,
        fontSize: levelHeight * 0.5,
        color: AppColors.textBlack);
    return SizedBox(
      height: levelHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          lvText,
          space,
          Text('$oldLevel', style: levelStyle),
          space,
          Image.asset(
            AppAnimationPath.arrow,
            height: levelHeight * 0.7,
            fit: BoxFit.fitHeight,
          ),
          space,
          lvText,
          space,
          Text('$newLevel', style: levelStyle),
        ],
      ),
    );
  }
}
