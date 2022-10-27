import 'package:flutter/material.dart';
import 'package:treasure_nft_project/models/http/parameter/task_info_data.dart';

import '../../../../constant/enum/task_enum.dart';
import '../../../../view_models/personal/level/level_achievement_viewmodel.dart';
import '../../../../widgets/label/mission/achievement_item_widget.dart';

///MARK: 成就任務
class AchievementAchieveView extends StatelessWidget {
  const AchievementAchieveView({Key? key, required this.viewModel})
      : super(key: key);
  final LevelAchievementViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return _buildItem(context, viewModel.achieveList[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
        itemCount: viewModel.achieveList.length);
  }

  Widget _buildItem(BuildContext context, TaskInfoData data) {
    return AchievementItemWidget(
        data: data,
        getPoint: (AchievementCode code, String recordNo, int point) =>
            viewModel.getAchievementPoint(context,data, code, recordNo, point));
  }
}
