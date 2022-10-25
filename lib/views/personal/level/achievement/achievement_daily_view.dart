import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';

import '../../../../constant/enum/task_enum.dart';
import '../../../../view_models/personal/level/level_achievement_viewmodel.dart';
import '../../../../widgets/label/task_item_widget.dart';

///MARK: 每日任務
class AchievementDailyView extends StatelessWidget {
  const AchievementDailyView({Key? key, required this.viewModel})
      : super(key: key);
  final LevelAchievementViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildItem(context, viewModel.dailyList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
        itemCount: viewModel.dailyList.length);
  }

  Widget _buildItem(BuildContext context, TaskInfoData data) {
    return TaskItemWidget(data: data, getPoint: _getPoint);
  }

  void _getPoint(String value) {}
}
