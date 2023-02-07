import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/medal_info_data.dart';
import 'package:treasure_nft_project/view_models/personal/level/level_achievement_view_model.dart';
import 'package:treasure_nft_project/widgets/label/icon/medal_icon_widget.dart';
import 'package:treasure_nft_project/widgets/label/warp_two_text_widget.dart';

///MARK: 徽章任務
class AchievementMedalView extends StatelessWidget {
  const AchievementMedalView({Key? key, required this.viewModel})
      : super(key: key);
  final LevelAchievementViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> lists = [];
    int nListCount =
        (viewModel.medalList.isNotEmpty) ? viewModel.medalList.length ~/ 3 : 0;
    for (int i = 0; i < nListCount + 1; i++) {
      List<Widget> row = [];
      row.add(Expanded(child: _buildIcon(context, i * 3)));
      row.add(Expanded(child: _buildIcon(context, i * 3 + 1)));
      row.add(Expanded(child: _buildIcon(context, i * 3 + 2)));
      lists.add(row);
    }

    return Container(
      color: Colors.white,
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
          itemBuilder: (context, index) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lists[index]);
          },
          itemCount: lists.length),
    );
  }

  Widget _buildIcon(BuildContext context, int index) {
    if (index >= viewModel.medalList.length) {
      return const SizedBox(height: kBottomNavigationBarHeight * 2);
    }
    MedalInfoData data = viewModel.medalList[index];

    return Container(
        decoration: (data.code == GlobalData.userInfo.medal)
            ? AppStyle().buildGradient(
                radius: 7, colors: AppColors.gradientBackgroundColorBg)
            : AppStyle().styleColorsRadiusBackground(radius: 0),
        constraints: BoxConstraints(minHeight: UIDefine.getPixelHeight(160)),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                MedalIconWidget(
                  medal: data.code,
                  enable: data.isFinished,
                  size: UIDefine.getPixelHeight(75),
                ),
                const SizedBox(height: 5),
                WarpTwoTextWidget(
                  warpAlignment: WrapAlignment.center,
                  maxLines: 4,
                  text: data.getMedalText(),
                  textAlign: TextAlign.center,
                  color: AppColors.textThreeBlack,
                  fontSize: UIDefine.fontSize12,
                )
              ],
            ),
          ),
        ));
  }
}
