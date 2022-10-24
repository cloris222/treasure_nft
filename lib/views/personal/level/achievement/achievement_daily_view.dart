import 'package:flutter/material.dart';

import '../../../../view_models/personal/level/level_achievement_viewmodel.dart';

///MARK: 每日任務
class AchievementDailyView extends StatelessWidget {
  const AchievementDailyView({Key? key, required this.viewModel})
      : super(key: key);
  final LevelAchievementViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('AchievementDailyView'),
    );
  }
}
