import 'package:flutter/material.dart';

import '../../../../view_models/personal/level/level_achievement_viewmodel.dart';

///MARK: 成就任務
class AchievementAchieveView extends StatelessWidget {
  const AchievementAchieveView({Key? key, required this.viewModel})
      : super(key: key);
  final LevelAchievementViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('AchievementAchieveView'),
    );
  }
}
