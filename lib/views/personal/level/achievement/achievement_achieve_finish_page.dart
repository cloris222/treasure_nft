import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';
import 'package:treasure_nft_project/utils/animation_download_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/gradient_text.dart';
import 'package:treasure_nft_project/widgets/label/icon/medal_icon_widget.dart';

class AchievementAchieveFinishPage extends StatelessWidget {
  AchievementAchieveFinishPage(
      {Key? key, required this.data, required this.code})
      : super(key: key);
  final AchievementCode code;
  final TaskInfoData data;
  final double pageHeight = UIDefine.getHeight() * 0.8;

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    String? path = AnimationDownloadUtil()
        .getAnimationFilePath(AppAnimationPath.achievementUnlockAnimation);
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
                  bottom: pageHeight * 0.2,
                  child: path != null
                      ? Lottie.file(File(path), fit: BoxFit.fill)
                      : const SizedBox()),
              Positioned(
                  top: pageHeight * 0.25,
                  child: MedalIconWidget(
                    medal: code.name,
                    size: pageHeight * 0.3,
                  )),
              Positioned(
                  bottom: 0,
                  left: UIDefine.getScreenWidth(10),
                  right: UIDefine.getScreenWidth(10),
                  child: _buildAchieveInfo(context)),
            ])));
  }

  Widget _buildAchieveInfo(BuildContext context) {
    return Column(children: [
      GradientText(
        data.getAchievementTaskText(),
        weight: FontWeight.w500,
        size: UIDefine.fontSize28,
        starColor: AppColors.reservationLevel2,
        endColor: AppColors.reservationLevel4,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        maxLines: 2,
        overflow: TextOverflow.visible,
      ),
      const Divider(color: AppColors.reservationLevel1, thickness: 2),
      _buildSpace(),
      Text(
        data.getAchievementGoalTaskSubText(code),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: UIDefine.fontSize16,
            color: AppColors.textGrey,
            fontWeight: FontWeight.w500),
      ),
      _buildSpace(height: 4),
      LoginButtonWidget(
        isFlip: true,
        width: UIDefine.getScreenWidth(40),
        btnText: tr('OK'),
        onPressed: () => {BaseViewModel().popPage(context)},
      ),
      _buildSpace(height: 1),
    ]);
  }

  Widget _buildSpace({double height = 1}) {
    return SizedBox(height: UIDefine.getScreenHeight(height));
  }
}
