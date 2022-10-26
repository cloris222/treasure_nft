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
  late TaskType currentType;
  late LevelAchievementViewModel viewModel;

  @override
  void initState() {
    super.initState();
    currentType = widget.initType;
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
      body: Column(children: [
        ///MARK: 不可以調成固定
        PersonalSubUserInfoView(userLevelInfo: viewModel.userLevelInfo),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              _buildButtonList(),
              const SizedBox(height: 10),
              _buildTaskView(),
              const SizedBox(height: 10),
            ]))
      ]),
    );
  }

  ///MARK: 選擇項目
  Widget _buildButtonList() {
    return Row(
        children: List<Widget>.from(
            TaskType.values.map((e) => Flexible(child: _buildButton(e)))));
  }

  Widget _buildButton(TaskType type) {
    String text = '';
    switch (type) {
      case TaskType.daily:
        text = tr('tab_daily');
        break;
      case TaskType.achieve:
        text = tr('tab_mission');
        break;
      case TaskType.medal:
        text = tr('tab_medal');
        break;
    }
    bool isCurrent = (currentType == type);

    return InkWell(
        onTap: () {
          setState(() {
            currentType = type;
          });
        },
        child: SizedBox(
            width: UIDefine.getWidth(),
            child: Column(children: [
              const SizedBox(height: 5),
              FlexTwoTextWidget(
                  alignment: Alignment.bottomCenter,
                  text: text,
                  color: isCurrent ? AppColors.textBlack : AppColors.dialogGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 5),
              isCurrent
                  ? const Divider(
                      color: AppColors.mainThemeButton, thickness: 2)
                  : const Divider(color: AppColors.textGrey)
            ])));
  }

  Widget _buildTaskView() {
    switch (currentType) {
      case TaskType.daily:
        return AchievementDailyView(viewModel: viewModel);
      case TaskType.achieve:
        return AchievementAchieveView(viewModel: viewModel);
      case TaskType.medal:
        return AchievementMedalView(viewModel: viewModel);
    }
  }
}
