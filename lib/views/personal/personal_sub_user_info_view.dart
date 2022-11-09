import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/custom_linear_progress.dart';
import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../utils/number_format_util.dart';
import '../../widgets/dialog/edit_avatar_dialog.dart';
import '../../widgets/label/icon/level_icon_widget.dart';
import '../../widgets/label/icon/medal_icon_widget.dart';
import '../login/circle_network_icon.dart';
import 'level/level_detail_page.dart';
import 'level/level_point_page.dart';

class PersonalSubUserInfoView extends StatelessWidget {
  const PersonalSubUserInfoView(
      {Key? key,
      this.showLevelInfo = false,
      this.showPoint = true,
      this.userLevelInfo,
      this.enableLevel = true,
      this.enablePoint = true,
      this.enableModify = false,
      this.setUserInfo,
      this.onViewUpdate})
      : super(key: key);
  final bool showLevelInfo;
  final bool showPoint;
  final CheckLevelInfo? userLevelInfo;
  final bool enableLevel;
  final bool enablePoint;

  ///MARK: 是否顯示他人
  final UserInfoData? setUserInfo;

  ///MARK: 修改頭像等
  final bool enableModify;
  final onClickFunction? onViewUpdate;

  UserInfoData get userInfo {
    return setUserInfo ?? GlobalData.userInfo;
  }

  @override
  Widget build(BuildContext context) {
    DecorationImage image;
    if (userInfo.bannerUrl.isNotEmpty) {
      image = DecorationImage(
          image: NetworkImage(userInfo.bannerUrl), fit: BoxFit.fill);
    } else {
      image = const DecorationImage(
          image: AssetImage(AppImagePath.defaultBanner), fit: BoxFit.fill);
    }
    return Stack(children: [
      GestureDetector(
          onTap: () => _showModifyBanner(context),
          child: Container(
              alignment: Alignment.topCenter,
              width: UIDefine.getWidth(),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(image: image),
              child: _buildFloatView(context)))
    ]);
  }

  Widget _buildFloatView(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            width: UIDefine.getWidth(),
            child: showLevelInfo
                ? InkWell(
                    onTap: () => _showLevelInfoPage(context),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(tr('levelDetail'),
                          style: TextStyle(
                              fontSize: UIDefine.fontSize12,
                              color: AppColors.dialogGrey)),
                      Image.asset(AppImagePath.rightArrow,
                          height: UIDefine.fontSize16)
                    ]))
                : const Text(''),
          ),
          GestureDetector(
              onTap: () => _showModifyAvatar(context),
              child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: userInfo.photoUrl.isNotEmpty
                      ? CircleNetworkIcon(
                          networkUrl: userInfo.photoUrl, radius: 35)
                      : Image.asset(
                          AppImagePath.avatarImg,
                          width: 70,
                          height: 70,
                        ))),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(userInfo.name,
                style: TextStyle(
                    fontSize: UIDefine.fontSize18,
                    fontWeight: FontWeight.w600)),
            const SizedBox(width: 5),
            _buildMedalIcon(context)
          ]),
          Container(
              margin: EdgeInsets.only(
                  left: showPoint
                      ? UIDefine.getWidth() / 8
                      : UIDefine.getWidth() / 4,
                  right: showPoint
                      ? UIDefine.getWidth() / 8
                      : UIDefine.getWidth() / 4,
                  top: 15),
              child: Row(children: [
                Flexible(
                    child: InkWell(
                        onTap: () => _showLevelInfoPage(context),
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.center,
                            width: UIDefine.getWidth(),
                            decoration: AppStyle().styleColorsRadiusBackground(
                                color: Colors.white.withOpacity(0.75),
                                radius: 10),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              LevelIconWidget(
                                  level: userInfo.level,
                                  size: UIDefine.fontSize18),
                              const SizedBox(width: 5),
                              Text('${tr('level')} ${userInfo.level}',
                                  style: TextStyle(
                                      fontSize: UIDefine.fontSize12,
                                      color: AppColors.dialogBlack)),
                            ])))),
                showPoint ? const SizedBox(width: 6) : const SizedBox(),
                showPoint
                    ? Flexible(
                        child: InkWell(
                            onTap: () => _showPointPage(context),
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.center,
                                width: UIDefine.getWidth(),
                                decoration: AppStyle()
                                    .styleColorsRadiusBackground(
                                        color: Colors.white.withOpacity(0.75),
                                        radius: 10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: UIDefine.fontSize18),
                                      Text(
                                          '${userInfo.point} ${tr('lv_point')}',
                                          style: TextStyle(
                                              fontSize: UIDefine.fontSize12,
                                              color: AppColors.dialogBlack)),
                                    ]))))
                    : const SizedBox()
              ])),
          userLevelInfo != null
              ? Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                    '${NumberFormatUtil().integerFormat(getPointPercentage() * 100)}%',
                    style: TextStyle(fontSize: UIDefine.fontSize12),
                  ),
                  CustomLinearProgress(
                    height: UIDefine.fontSize12,
                    percentage: getPointPercentage(),
                  )
                ])
              : Container()
        ]);
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

  double getPointPercentage() {
    return userLevelInfo?.getPointPercentage() ?? 0;
  }

  void _showModifyBanner(BuildContext context) {
    if (enableModify) {
      EditAvatarDialog(context, isAvatar: false, onChange: () {
        if (onViewUpdate != null) {
          onViewUpdate!();
        }
      }).show();
    }
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
}
