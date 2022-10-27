import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/icon/medal_icon_widget.dart';

import '../../../../constant/enum/task_enum.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../../models/http/parameter/task_info_data.dart';
import '../../../../widgets/button/login_button_widget.dart';
import '../../../../widgets/gradient_text.dart';

class AchievementAchieveFinishPage extends StatelessWidget {
  const AchievementAchieveFinishPage(
      {Key? key, required this.data, required this.code})
      : super(key: key);
  final AchievementCode code;
  final TaskInfoData data;

  @override
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(padding),
            child: Container(
              color: Colors.white,
              padding:  EdgeInsets.symmetric(horizontal:UIDefine.getScreenWidth(5)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Stack(alignment: Alignment.center, children: [
                      Lottie.asset(AppAnimationPath.achievementUnlockAnimation,
                          fit: BoxFit.contain),
                      Positioned(
                          top: UIDefine.getScreenHeight(22.5),
                          child: MedalIconWidget(
                            medal: code.name,
                            size: UIDefine.getScreenWidth(52.5),
                          )),
                      Positioned(
                          bottom: 0,
                          left: UIDefine.getScreenWidth(10),
                          right: UIDefine.getScreenWidth(10),
                          child: _buildAchieveInfo(context))
                    ]),
                  ),
                  LoginButtonWidget(
                    isFlip: true,
                    width: UIDefine.getScreenWidth(40),
                    btnText: tr('OK'),
                    onPressed: () => {BaseViewModel().popPage(context)},
                  ),
                  _buildSpace(height: 2),
                ],
              ),
            )));
  }

  Widget _buildAchieveInfo(BuildContext context) {
    return Column(children: [
      GradientText(
        data.getAchievementTaskText(),
        weight: FontWeight.bold,
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
            fontWeight: FontWeight.w600),
      ),
      _buildSpace(height: 4),
    ]);
  }

  Widget _buildSpace({double height = 1}) {
    return SizedBox(height: UIDefine.getScreenHeight(height));
  }
}
