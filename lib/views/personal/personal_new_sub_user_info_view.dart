import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:treasure_nft_project/models/http/parameter/check_level_info.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/views/personal/level/level_achievement_page.dart';
import 'package:treasure_nft_project/widgets/label/custom_linear_progress.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../constant/call_back_function.dart';
import '../../constant/global_data.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_theme.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/dialog/edit_avatar_dialog.dart';
import '../../widgets/label/icon/level_icon_widget.dart';
import '../../widgets/label/icon/medal_icon_widget.dart';
import '../../widgets/label/warp_two_text_widget.dart';
import '../login/circle_network_icon.dart';
import 'level/level_detail_page.dart';
import 'level/level_point_page.dart';

class PersonalNewSubUserInfoView extends StatelessWidget {
  const PersonalNewSubUserInfoView(
      {super.key,
      this.setUserInfo,
      this.onViewUpdate,
      this.showDailyTask = false,
      this.enableLevel = true,
      this.enablePoint = true,
      this.showId = true,
      this.showPoint = true,
      this.enableModify = false,
      this.userLevelInfo,
      this.shareUrl});

  ///MARK: 是否顯示他人
  final UserInfoData? setUserInfo;
  final onClickFunction? onViewUpdate;
  final bool showDailyTask;
  final CheckLevelInfo? userLevelInfo;
  final bool enableLevel;
  final bool enablePoint;

  final bool enableModify;
  final bool showPoint;
  final bool showId;
  final String? shareUrl;

  UserInfoData get userInfo {
    return setUserInfo ?? GlobalData.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () => _showModifyAvatar(context),
                child: Container(
                    decoration: AppTheme.style.baseGradient(radius: 65),
                    height: UIDefine.getPixelWidth(65),
                    width: UIDefine.getPixelWidth(65),
                    padding: const EdgeInsets.all(3),
                    child: userInfo.photoUrl.isNotEmpty
                        ? CircleNetworkIcon(
                            networkUrl: userInfo.photoUrl, radius: 35)
                        : Image.asset(
                            AppImagePath.avatarImg,
                            width: UIDefine.getScreenWidth(18.66),
                            height: UIDefine.getScreenWidth(18.66),
                            fit: BoxFit.contain,
                          ))),
            SizedBox(width: UIDefine.getScreenWidth(2.7)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      WarpTwoTextWidget(
                          text: userInfo.name,
                          fontSize: UIDefine.fontSize18,
                          fontWeight: FontWeight.w600),
                      SizedBox(width: UIDefine.getPixelWidth(5)),
                      _buildMedalIcon(context),
                      const Spacer(),
                      GestureDetector(
                          onTap: () => _onPressDailyTask(context),
                          child: Visibility(
                              visible: showDailyTask,
                              child: BaseIconWidget(
                                imageAssetPath: AppImagePath.dateIcon,
                                size: UIDefine.getPixelWidth(15),
                              )))
                    ],
                  ),
                  SizedBox(height: UIDefine.getPixelWidth(7)),

                  ///MARK:使用者的ID和邀請碼
                  Visibility(
                      visible: showId, child: _buildOtherDetailInfo(context)),

                  ///MARK: 使用者的按鈕
                  Row(children: [
                    InkWell(
                        onTap: () => _showLevelInfoPage(context),
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: AppColors.textGrey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(children: [
                              const SizedBox(width: 5),
                              LevelIconWidget(
                                  level: userInfo.level,
                                  size: UIDefine.fontSize18),
                              const SizedBox(width: 5),
                              Text('${tr('level')} ${userInfo.level}',
                                  style: AppTextStyle.getBaseStyle(
                                      fontSize: UIDefine.fontSize12,
                                      color: AppColors.textBlack)),
                              SizedBox(width: UIDefine.getScreenWidth(2)),
                              Image.asset(AppImagePath.arrowRight)
                            ]))),
                    const SizedBox(width: 6),
                    Visibility(
                      visible: showPoint,
                      child: InkWell(
                          onTap: () => _showPointPage(context),
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border:
                                    Border.all(color: AppColors.textNineBlack),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 5),
                                    SizedBox(height: UIDefine.fontSize18),
                                    Text('${userInfo.point} ${tr('lv_point')}',
                                        style: AppTextStyle.getBaseStyle(
                                            fontSize: UIDefine.fontSize12,
                                            color: AppColors.textBlack,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(width: UIDefine.getScreenWidth(2)),
                                    Image.asset(AppImagePath.arrowRight)
                                  ]))),
                    ),
                    Visibility(
                        visible: shareUrl != null,
                        child: GestureDetector(
                            onTap: () => Share.share(shareUrl ?? ''),
                            child: BaseIconWidget(
                                imageAssetPath:
                                    'assets/icon/icon/icon_share_03.png',
                                size: UIDefine.getScreenWidth(6)))),
                  ])
                ],
              ),
            )
          ],
        ),
        userLevelInfo != null
            ? Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  '${NumberFormatUtil().integerFormat(getPointPercentage() * 100)}%',
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize10,
                      color: AppColors.textNineBlack,
                      fontWeight: FontWeight.w400),
                ),
                CustomLinearProgress(
                  percentage: getPointPercentage(),
                ),
              ])
            : Container()
      ],
    );
  }

  double getPointPercentage() {
    return userLevelInfo?.getPointPercentage() ?? 0;
  }

  Widget _buildMedalIcon(BuildContext context) {
    if (userInfo.medal.isNotEmpty) {
      return InkWell(
          onTap: () => _showPointPage(context),
          child: MedalIconWidget(
            medal: userInfo.medal,
            size: UIDefine.fontSize24,
          ));
    }
    return Container();
  }

  Widget _buildOtherDetailInfo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(${userInfo.account})',
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize12,
                color: AppColors.textThreeBlack)),
        Row(children: [
          Text('UID : ',
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12,
                  color: AppColors.textThreeBlack)),
          Text(userInfo.inviteCode,
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12,
                  color: AppColors.textThreeBlack)),
          GestureDetector(
              onTap: () {
                BaseViewModel().copyText(copyText: userInfo.inviteCode);
                BaseViewModel().showToast(context, tr('copiedSuccess'));
              },
              child: Padding(
                  padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
                  child: BaseIconWidget(
                      imageAssetPath: AppImagePath.copyIcon,
                      size: UIDefine.getPixelWidth(15))))
        ]),
      ],
    );
  }

  void _showModifyAvatar(BuildContext context) {
    if (enableModify) {
      EditAvatarDialog(context, isAvatar: true, onChange: () {
        if (onViewUpdate != null) {
          onViewUpdate!();
        }
      }).show();
    }
  }

  void _showLevelInfoPage(BuildContext context) {
    if (enableLevel) {
      BaseViewModel().pushPage(context, const LevelDetailPage());
    }
  }

  void _showPointPage(BuildContext context) {
    if (enablePoint) {
      BaseViewModel().pushPage(context, const LevelPointPage());
    }
  }

  void _onPressDailyTask(BuildContext context) {
    BaseViewModel().pushPage(context, const LevelAchievementPage());
  }
}
