import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';
import 'package:treasure_nft_project/view_models/personal/level/level_achievement_view_model.dart';
import 'package:treasure_nft_project/widgets/list_view/mission/daily_item_widget.dart';

///MARK: 每日任務
class AchievementDailyView extends StatelessWidget {
  const AchievementDailyView({Key? key, required this.viewModel})
      : super(key: key);
  final LevelAchievementViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index >= viewModel.dailyList.length) {
            return const SizedBox(height: kBottomNavigationBarHeight * 2);
          }
          return _buildItem(context, viewModel.dailyList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
        itemCount: viewModel.dailyList.length + 1);
  }

  Widget _buildItem(BuildContext context, TaskInfoData data) {
    return DailyItemWidget(
        data: data,
        getPoint: (String recordNo, int point) =>
            viewModel.getDailyPoint(context, recordNo, point));
  }
}
