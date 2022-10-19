import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../login/circle_network_icon.dart';
import 'level/level_detail_page.dart';
import 'level/level_point_page.dart';

class PersonalSubUserInfoView extends StatelessWidget {
  const PersonalSubUserInfoView({Key? key, this.showLevelInfo = false})
      : super(key: key);
  final bool showLevelInfo;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        alignment: Alignment.topCenter,
        child: GlobalData.userInfo.bannerUrl.isNotEmpty
            ? Image.network(
                width: UIDefine.getWidth(),
                GlobalData.userInfo.bannerUrl,
                fit: BoxFit.fill,
              )
            : Image.asset(
                width: UIDefine.getWidth(),
                AppImagePath.defaultBanner,
                fit: BoxFit.fitWidth,
              ),
      ),
      Positioned(
          left: 0,
          right: 0,
          top: 10,
          child: _buildFloatView(context))
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(tr('levelDetail'),
                            style: TextStyle(
                                fontSize: UIDefine.fontSize12,
                                color: AppColors.dialogGrey)),
                        Image.asset(AppImagePath.rightArrow,
                            height: UIDefine.fontSize16)
                      ],
                    ),
                  )
                : const Text(''),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: GlobalData.userInfo.photoUrl.isNotEmpty
                ? CircleNetworkIcon(
                    networkUrl: GlobalData.userInfo.photoUrl, radius: 35)
                : Image.asset(
                    AppImagePath.avatarImg,
                    width: 70,
                    height: 70,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(GlobalData.userInfo.name,
                  style: TextStyle(
                      fontSize: UIDefine.fontSize18,
                      fontWeight: FontWeight.w600)),
              const SizedBox(width: 5),
              _buildMedalIcon(context)
            ],
          ),
          Row(children: [
            Flexible(
                child: InkWell(
              onTap: () => _showLevelInfoPage(context),
              child: Container(
                margin: EdgeInsets.only(
                    left: UIDefine.getWidth() / 8, right: 3, top: 5),
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                width: UIDefine.getWidth(),
                decoration: AppStyle().styleColorsRadiusBackground(
                    color: Colors.white.withOpacity(0.75), radius: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      format(AppImagePath.level,
                          ({'level': GlobalData.userInfo.level})),
                      width: UIDefine.fontSize18,
                      height: UIDefine.fontSize18,
                    ),
                    const SizedBox(width: 5),
                    Text('${tr('level')} ${GlobalData.userInfo.level}',
                        style: TextStyle(
                            fontSize: UIDefine.fontSize12,
                            color: AppColors.dialogBlack)),
                  ],
                ),
              ),
            )),
            Flexible(
                child: InkWell(
              onTap: () => _showPointPage(context),
              child: Container(
                margin: EdgeInsets.only(
                    right: UIDefine.getWidth() / 8, left: 3, top: 5),
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                width: UIDefine.getWidth(),
                decoration: AppStyle().styleColorsRadiusBackground(
                    color: Colors.white.withOpacity(0.75), radius: 5),
                child: Text('${GlobalData.userInfo.point} ${tr('lv_point')}',
                    style: TextStyle(
                        fontSize: UIDefine.fontSize12,
                        color: AppColors.dialogBlack)),
              ),
            ))
          ])
        ]);
  }

  Widget _buildMedalIcon(BuildContext context) {
    if (GlobalData.userInfo.medal.isNotEmpty) {
      String mainNumber = '';
      switch (GlobalData.userInfo.medal) {

        /// 累計簽到
        case "AchSignIn":
          mainNumber = '01';
          break;

        /// 累計連續簽到
        case "AchContSignIn":
          mainNumber = '02';
          break;

        /// 累計預約成功
        case "AchRsvScs":
          mainNumber = '03';
          break;

        /// 累計購買成功
        case "AchBuyScs":
          mainNumber = '04';
          break;

        /// 累計自己購買滿額
        case "AchSlfBuyAmt":
          mainNumber = '05';
          break;

        /// 累計團隊購買次數
        case "AchTeamBuyFreq":
          mainNumber = '06';
          break;

        /// 累計團隊購買金額
        case "AchTeamBuyAmt":
          mainNumber = '07';
          break;

        /// 累計邀請有效A級
        case "AchInvClsA":
          mainNumber = '08';
          break;

        /// 累計邀請有效B或C級
        case "AchInvClsBC":
          mainNumber = '09';
          break;
      }
      return InkWell(
        onTap: () => _showPointPage(context),
        child: Image.asset(
          format(AppImagePath.medalIcon, {'mainNumber': mainNumber}),
          width: UIDefine.fontSize24,
          height: UIDefine.fontSize24,
        ),
      );
    }
    return Container();
  }

  void _showLevelInfoPage(BuildContext context) {
    BaseViewModel().pushPage(context, const LevelDetailPage());
  }

  _showPointPage(BuildContext context) {
    BaseViewModel().pushPage(context, const LevelPointPage());
  }
}
