import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/custom_linear_progress.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../utils/number_format_util.dart';
import '../../widgets/label/icon/level_icon_widget.dart';
import '../../widgets/label/icon/medal_icon_widget.dart';
import '../login/circle_network_icon.dart';
import 'level/level_detail_page.dart';
import 'level/level_point_page.dart';

class PersonalSubUserInfoView extends StatelessWidget {
  const PersonalSubUserInfoView(
      {Key? key, this.showLevelInfo = false, this.userLevelInfo})
      : super(key: key);
  final bool showLevelInfo;
  final CheckLevelInfo? userLevelInfo;

  @override
  Widget build(BuildContext context) {
    DecorationImage image;
    if (GlobalData.userInfo.bannerUrl.isNotEmpty) {
      image = DecorationImage(
          image: NetworkImage(GlobalData.userInfo.bannerUrl), fit: BoxFit.fill);
    } else {
      image = const DecorationImage(
          image: AssetImage(AppImagePath.defaultBanner), fit: BoxFit.fill);
    }
    return Stack(children: [
      Container(
        alignment: Alignment.topCenter,
        width: UIDefine.getWidth(),
        padding:  const EdgeInsets.all(20),
        decoration: BoxDecoration(image: image),
        child: Opacity(
          opacity: 0,
          child: _buildFloatView(context),
        ),
      ),
      Positioned(left: 10, right: 10, top: 20, child: _buildFloatView(context))
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
            margin: const EdgeInsets.only(bottom: 15),
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
                    left: UIDefine.getWidth() / 8, right: 3, top: 15),
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                width: UIDefine.getWidth(),
                decoration: AppStyle().styleColorsRadiusBackground(
                    color: Colors.white.withOpacity(0.75), radius: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LevelIconWidget(
                        level: GlobalData.userInfo.level,
                        size: UIDefine.fontSize18),
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
                    right: UIDefine.getWidth() / 8, left: 3, top: 15),
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                width: UIDefine.getWidth(),
                decoration: AppStyle().styleColorsRadiusBackground(
                    color: Colors.white.withOpacity(0.75), radius: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: UIDefine.fontSize18),
                    Text('${GlobalData.userInfo.point} ${tr('lv_point')}',
                        style: TextStyle(
                            fontSize: UIDefine.fontSize12,
                            color: AppColors.dialogBlack)),
                  ],
                ),
              ),
            ))
          ]),
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
    if (GlobalData.userInfo.medal.isNotEmpty) {
      return InkWell(
          onTap: () => _showPointPage(context),
          child: MedalIconWidget(
            medal: GlobalData.userInfo.medal,
            size: UIDefine.fontSize24,
          ));
    }
    return Container();
  }

  void _showLevelInfoPage(BuildContext context) {
    BaseViewModel().pushPage(context, const LevelDetailPage());
  }

  _showPointPage(BuildContext context) {
    BaseViewModel().pushPage(context, const LevelPointPage());
  }

  double getPointPercentage() {
    return userLevelInfo?.getPointPercentage() ?? 0;
  }
}
