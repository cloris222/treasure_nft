import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:treasure_nft_project/utils/custom_text_style.dart';

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
  const PersonalNewSubUserInfoView({
  super.key,
  this.setUserInfo,
  this.onViewUpdate
  });

  ///MARK: 是否顯示他人
  final UserInfoData? setUserInfo;
  final onClickFunction? onViewUpdate;

  UserInfoData get userInfo {
    return setUserInfo ?? GlobalData.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () => _showModifyAvatar(context),
            child: Container(
                decoration: AppTheme.style.baseGradient(radius: 100),
                height: UIDefine.getPixelWidth(75),
                width: UIDefine.getPixelWidth(75),
                padding: const EdgeInsets.all(2),
                child: userInfo.photoUrl.isNotEmpty
                    ? CircleNetworkIcon(
                    networkUrl: userInfo.photoUrl, radius: 35)
                    : Image.asset(
                  AppImagePath.avatarImg,
                  width: UIDefine.getScreenWidth(18.66), height: UIDefine.getScreenWidth(18.66),
                ))
        ),
        
        SizedBox(width: UIDefine.getScreenWidth(2.7)),
        
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                WarpTwoTextWidget(
                    text: userInfo.name,
                    fontSize: UIDefine.fontSize18,
                    fontWeight: FontWeight.w500),
                const SizedBox(width: 5),
                _buildMedalIcon(context)
              ],
            ),

            SizedBox(height: UIDefine.getScreenWidth(2.77)),

            Row(
              children: [
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

                          child: Row(
                              children: [
                                const SizedBox(width: 5),
                                LevelIconWidget(
                                    level: userInfo.level,
                                    size: UIDefine.fontSize18),
                                const SizedBox(width: 5),
                                Text('${tr('level')} ${userInfo.level}',
                                    style: CustomTextStyle.getBaseStyle(
                                        fontSize: UIDefine.fontSize12,
                                        color: AppColors.dialogBlack)),
                                SizedBox(width: UIDefine.getScreenWidth(2)),
                                Image.asset(AppImagePath.rightArrow)
                              ]))),
                const SizedBox(width: 6),
                InkWell(
                      onTap: () => _showPointPage(context),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: AppColors.textGrey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 5),
                                SizedBox(height: UIDefine.fontSize18),
                                Text(
                                    '${userInfo.point} ${tr('lv_point')}',
                                    style: CustomTextStyle.getBaseStyle(
                                        fontSize: UIDefine.fontSize12,
                                        color: AppColors.dialogBlack)),
                                SizedBox(width: UIDefine.getScreenWidth(2)),
                                Image.asset(AppImagePath.rightArrow)
                              ])))
            ])
          ],
        )
      ],
    );
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

  void _showModifyAvatar(BuildContext context) {
    EditAvatarDialog(context, isAvatar: true, onChange: () {
      if (onViewUpdate != null) {
        onViewUpdate!();
      }
    }).show();
  }

  void _showLevelInfoPage(BuildContext context) {
    BaseViewModel().pushPage(context, const LevelDetailPage());
  }

  void _showPointPage(BuildContext context) {
    BaseViewModel().pushPage(context, const LevelPointPage());
  }
  
}