import 'package:flutter/material.dart';

import '../../../../view_models/personal/level/level_achievement_viewmodel.dart';

///MARK: 徽章任務
class AchievementMedalView extends StatelessWidget {
  const AchievementMedalView({Key? key, required this.viewModel})
      : super(key: key);
  final LevelAchievementViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('AchievementMedalView'),
    );
  }
}
