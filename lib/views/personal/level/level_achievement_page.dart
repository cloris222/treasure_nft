import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
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
import 'package:treasure_nft_project/widgets/slider_page_view.dart';

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
      needCover: true,
      needScrollView: true,
      body: _buildPageView(context),
      backgroundColor: AppColors.defaultBackgroundSpace,
    );
  }

  Widget _buildPreButton() {
    return GestureDetector(
      onTap: () => viewModel.popPage(context),
      child: Image.asset(
        AppImagePath.arrowLeftBlack,
        height: UIDefine.getPixelWidth(24),
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return SliderPageView(
        backgroundColor: AppColors.defaultBackgroundSpace,
        buttonDecoration: AppStyle().styleColorsRadiusBackground(
            hasBottomRight: false, hasBottomLef: false),
        titles: titles,
        initialPage: TaskType.values.indexOf(widget.initType),
        topView: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                height: UIDefine.getPixelWidth(210),
                width: UIDefine.getWidth(),
                child: Image.asset(AppImagePath.backgroundLand,
                    fit: BoxFit.cover)),
            Positioned(
                top: UIDefine.getPixelWidth(140),
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    decoration: AppStyle().styleColorsRadiusBackground(
                        hasBottomLef: false,
                        hasBottomRight: false,
                        color: AppColors.defaultBackgroundSpace,
                        radius: 12))),
            Positioned(top: UIDefine.getPixelWidth(6), left:  UIDefine.getPixelWidth(10), child: _buildPreButton()),
            Positioned(
              top: UIDefine.getPixelWidth(30),
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  margin: EdgeInsets.all(UIDefine.getPixelWidth(10)),
                  padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
                  decoration: AppStyle().styleNewUserSetting(),
                  child: PersonalNewSubUserInfoView(
                      userLevelInfo: GlobalData.userLevelInfo)),
            ),
          ],
        ),
        children: [
          AchievementDailyView(viewModel: viewModel),
          AchievementAchieveView(viewModel: viewModel),
          AchievementMedalView(viewModel: viewModel),
        ]);
  }
}
