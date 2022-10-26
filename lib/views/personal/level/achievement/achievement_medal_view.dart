import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/label/flex_two_text_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/medal_icon_widget.dart';

import '../../../../constant/call_back_function.dart';
import '../../../../constant/global_data.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../../constant/theme/app_style.dart';
import '../../../../models/http/parameter/medal_info_data.dart';
import '../../../../view_models/personal/level/level_achievement_viewmodel.dart';

///MARK: 徽章任務
class AchievementMedalView extends StatelessWidget {
  const AchievementMedalView({Key? key, required this.viewModel})
      : super(key: key);
  final LevelAchievementViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2),
        itemCount: viewModel.medalList.length,
        itemBuilder: _buildIcon);
  }

  Widget _buildIcon(BuildContext context, int index) {
    MedalInfoData data = viewModel.medalList[index];

    return Container(
        decoration: AppStyle().styleColorsRadiusBackground(
          color: (data.code == GlobalData.userInfo.medal)
              ? AppColors.bolderGrey
              : Colors.transparent,
        ),
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            if (data.isFinished) {
              viewModel.setMedalCode(context, data.code);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MedalIconWidget(
                  medal: data.code,
                  enable: data.isFinished,
                  size: UIDefine.getScreenWidth(20),
                ),
                const SizedBox(height: 5),
                FlexTwoTextWidget(
                  text: data.getMedalText(),
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                )
              ],
            ),
          ),
        ));
  }
}
