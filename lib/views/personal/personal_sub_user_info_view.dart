import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../login/circle_network_icon.dart';

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
                height: 200,
                GlobalData.userInfo.bannerUrl,
                fit: BoxFit.fill,
              )
            : Image.asset(
                width: UIDefine.getWidth(),
                height: 200,
                AppImagePath.defaultBanner,
                fit: BoxFit.fitWidth,
              ),
      ),
      Positioned(
          left: 0, right: 0, top: 10, bottom: 30, child: _buildFloatView())
    ]);
  }

  Widget _buildFloatView() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            width: UIDefine.getWidth(),
            child: showLevelInfo
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(tr('levelDetail'),
                          style: TextStyle(
                              fontSize: UIDefine.fontSize12,
                              color: AppColors.dialogGrey)),
                      Image.asset(AppImagePath.rightArrow,
                          height: UIDefine.fontSize16)
                    ],
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
          Text(GlobalData.userInfo.name,
              style: TextStyle(
                  fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w600)),
          Row(children: [
            Flexible(
                child: Container(
              margin: EdgeInsets.only(left: UIDefine.getWidth() / 6, right: 5),
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              width: UIDefine.getWidth(),
              decoration: AppStyle().styleColorsRadiusBackground(
                  color: Colors.white.withOpacity(0.5), radius: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    format(AppImagePath.level,
                        ({'level': GlobalData.userInfo.level})),
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 5),
                  Text('${tr('level')} ${GlobalData.userInfo.level}',
                      style: TextStyle(
                          fontSize: UIDefine.fontSize12,
                          color: AppColors.dialogBlack)),
                ],
              ),
            )),
            Flexible(
                child: Container(
              margin: EdgeInsets.only(right: UIDefine.getWidth() / 6, left: 5),
              padding: const EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              width: UIDefine.getWidth(),
              decoration: AppStyle().styleColorsRadiusBackground(
                  color: Colors.white.withOpacity(0.5), radius: 5),
              child: Text('${GlobalData.userInfo.point} ${tr('lv_point')}',
                  style: TextStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.dialogBlack)),
            ))
          ])
        ]);
  }
}
