import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/login/register_main_page.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_achieve_view.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_daily_view.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_medal_view.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../../constant/enum/task_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../view_models/personal/level/level_achievement_viewmodel.dart';
import '../../../widgets/dialog/common_custom_dialog.dart';
import '../../../widgets/label/flex_two_text_widget.dart';
import '../../../widgets/slider_page_view.dart';
import '../../custom_appbar_view.dart';

///MARK: 成就
class LevelAchievementPage extends StatefulWidget {
  const LevelAchievementPage({Key? key, this.initType = TaskType.daily})
      : super(key: key);
  final TaskType initType;

  @override
  State<LevelAchievementPage> createState() => _LevelAchievementPageState();
}

class _LevelAchievementPageState extends State<LevelAchievementPage> {
  late LevelAchievementViewModel viewModel;

  List<String> titles = [
    tr('tab_daily'),
    tr('tab_mission'),
    tr('tab_medal'),
  ];
  @override
  void initState() {
    super.initState();
    viewModel = LevelAchievementViewModel(
        setState: setState,
        showExperienceHint: () {
          CommonCustomDialog(context,
              isDialogCancel: false,
              bOneButton: false,
              title: tr('exp_remind_title'),
              content: tr('exp_remind_content'),
              leftBtnText: tr('confirm'),
              rightBtnText: tr('gotoRegister'),
              type: DialogImageType.fail, onLeftPress: () {
            BaseViewModel().popPage(context);
            BaseViewModel().popPage(context);
          }, onRightPress: () {
            BaseViewModel().popPage(context);
            BaseViewModel().popPage(context);
            BaseViewModel().pushPage(context, const RegisterMainPage());
          }).show();
        },
        showLevel0Hint: () {
          CommonCustomDialog(context,
              isDialogCancel: false,
              bOneButton: true,
              title: tr('yourLevelNotEnough'),
              content: tr('pleaseNoviceVillageLevelUp'),
              leftBtnText: tr('confirm'),
              rightBtnText: tr('confirm'),
              type: DialogImageType.fail, onLeftPress: () {
            BaseViewModel().popPage(context);
            BaseViewModel().popPage(context);
          }, onRightPress: () {
            BaseViewModel().popPage(context);
            BaseViewModel().pushAndRemoveUntil(
                context, const MainPage(type: AppNavigationBarType.typeTrade));
          }).show();
        });
    viewModel.initState();

  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      title: tr('achievement'),
      body: _buildPageView(context),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return SliderPageView(
        titles: titles,
        initialPage: TaskType.values.indexOf(widget.initType),
        topView:
            PersonalSubUserInfoView(userLevelInfo: viewModel.userLevelInfo),
        children: [
          AchievementDailyView(viewModel: viewModel),
          AchievementAchieveView(viewModel: viewModel),
          AchievementMedalView(viewModel: viewModel),
        ]);
  }
}
