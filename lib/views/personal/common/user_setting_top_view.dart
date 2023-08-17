import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/level_icon_widget.dart';

import '../../../constant/call_back_function.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_theme.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/user_info_data.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/gobal_provider/user_info_provider.dart';
import '../../../widgets/dialog/edit_avatar_dialog.dart';
import '../../../widgets/label/icon/medal_icon_widget.dart';
import '../../../widgets/label/warp_two_text_widget.dart';
import '../../login/circle_network_icon.dart';
import '../level/level_point_page.dart';

class UserSettingTopView extends ConsumerWidget {
  const UserSettingTopView({
    super.key,
    this.onViewUpdate,
    this.enablePoint = true,
    this.enableModify = false,
    this.isHideName = false,
  });

  final onClickFunction? onViewUpdate;
  final bool enablePoint;
  final bool enableModify;
  final bool isHideName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserInfoData userInfo = ref.watch(userInfoProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () => _showModifyAvatar(context, ref),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Container(
                        decoration: AppTheme.style.baseGradient(radius: 65),
                        height: UIDefine.getPixelWidth(65),
                        width: UIDefine.getPixelWidth(65),
                        padding: const EdgeInsets.all(3),
                        child: userInfo.photoUrl.isNotEmpty
                            ? CircleNetworkIcon(showNormal: true, networkUrl: userInfo.photoUrl, radius: 35)
                            : Image.asset(
                                AppImagePath.avatarImg,
                                width: UIDefine.getScreenWidth(18.66),
                                height: UIDefine.getScreenWidth(18.66),
                                fit: BoxFit.contain,
                              )),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: BaseIconWidget(imageAssetPath: AppImagePath.userEditAvatar, size: UIDefine.getPixelWidth(20)),
                    )
                  ],
                )),
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
                          text: isHideName
                              ? userInfo.getUserName() != ""
                                  ? userInfo.getUserName().replaceRange(1, null, '....')
                                  : ""
                              : userInfo.getUserName(),
                          fontSize: UIDefine.fontSize18,
                          fontWeight: FontWeight.w600),
                      SizedBox(width: UIDefine.getPixelWidth(5)),
                      _buildLevelIcon(context, userInfo),
                      _buildMedalIcon(context, userInfo),
                    ],
                  ),
                  SizedBox(height: UIDefine.getPixelWidth(7)),

                  ///MARK: 使用者的按鈕
                  GestureDetector(
                      onTap: () => _showPointPage(context),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(2.3)),
                          alignment: Alignment.center,
                          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Text(
                              '${tr('lv_point')} : ',
                              style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12, color: AppColors.textThreeBlack, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '${userInfo.point}',
                              style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12, color: AppColors.textSixBlack, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(width: UIDefine.getPixelWidth(5)),
                            Image.asset(
                              AppImagePath.arrowRight,
                              height: UIDefine.getPixelWidth(12),
                            )
                          ])))
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildMedalIcon(BuildContext context, UserInfoData userInfo) {
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

  Widget _buildLevelIcon(BuildContext context, UserInfoData userInfo) {
    return LevelIconWidget(
      level: userInfo.level,
      size: UIDefine.fontSize24,
    );
  }

  void _showModifyAvatar(BuildContext context, WidgetRef ref) {
    if (enableModify) {
      EditAvatarDialog(context, isAvatar: true, onChange: () {
        if (onViewUpdate != null) {
          // onViewUpdate!();
          ref.read(userInfoProvider.notifier).update();
        }
      }).show();
    }
  }

  void _showPointPage(BuildContext context) {
    if (enablePoint) {
      BaseViewModel().pushPage(context, const LevelPointPage());
    }
  }
}
