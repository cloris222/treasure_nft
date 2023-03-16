import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_level_info_provider.dart';
import 'package:treasure_nft_project/view_models/personal/level/level_achievement_view_model.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/login/register_main_page.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_achieve_view.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_daily_view.dart';
import 'package:treasure_nft_project/views/personal/level/achievement/achievement_medal_view.dart';
import 'package:treasure_nft_project/views/personal/personal_new_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/label/background_with_land.dart';
import 'package:treasure_nft_project/widgets/slider_page_view.dart';

///MARK: 成就
class LevelAchievementPage extends ConsumerStatefulWidget {
  const LevelAchievementPage({Key? key, this.initType = TaskType.daily})
      : super(key: key);
  final TaskType initType;

  @override
  ConsumerState createState() => _LevelAchievementPageState();
}

class _LevelAchievementPageState extends ConsumerState<LevelAchievementPage> {
  late LevelAchievementViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LevelAchievementViewModel(onViewChange: () {
      if (mounted) {
        setState(() {});
      }
    }, showExperienceHint: () {
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
    }, showLevel0Hint: () {
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
    viewModel.initState(ref);
    ref.read(userLevelInfoProvider.notifier).update();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needCover: true,
      needScrollView: true,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: _buildPageView(context),
      backgroundColor: AppColors.defaultBackgroundSpace,
    );
  }

  Widget _buildPageView(BuildContext context) {
    List<String> titles = [
      tr('tab_daily'),
      tr('tab_mission'),
      tr('tab_medal'),
    ];
    return SliderPageView(
        backgroundColor: AppColors.defaultBackgroundSpace,
        buttonDecoration: AppStyle().styleColorsRadiusBackground(
            hasBottomRight: false, hasBottomLef: false),
        titles: titles,
        initialPage: TaskType.values.indexOf(widget.initType),
        topView: BackgroundWithLand(
            mainHeight: 230,
            bottomHeight: 100,
            onBackPress: () => viewModel.popPage(context),
            body: Container(
              margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
              padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
              decoration: AppStyle().styleNewUserSetting(),
              child: PersonalNewSubUserInfoView(
                  userLevelInfo: ref.watch(userLevelInfoProvider)),
            )),
        children: [
          AchievementDailyView(viewModel: viewModel),
          AchievementAchieveView(viewModel: viewModel),
          AchievementMedalView(viewModel: viewModel),
        ]);
  }
}
