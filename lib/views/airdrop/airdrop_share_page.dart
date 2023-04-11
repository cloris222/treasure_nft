import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/global_data.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/airdrop_box_reward.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../utils/app_text_style.dart';
import '../../view_models/gobal_provider/user_info_provider.dart';
import '../../widgets/label/icon/level_icon_widget.dart';
import '../../widgets/label/icon/medal_icon_widget.dart';
import '../login/circle_network_icon.dart';

class AirdropSharePage extends ConsumerStatefulWidget {
  const AirdropSharePage({
    Key? key,
    required this.level,
    required this.reward,
  }) : super(key: key);
  final int level;
  final AirdropBoxReward reward;

  @override
  ConsumerState createState() => _AirdropSharePageState();
}

class _AirdropSharePageState extends ConsumerState<AirdropSharePage> {
  GlobalKey repaintKey = GlobalKey();

  /// 獎勵清單
  AirdropBoxReward get reward => widget.reward;

  @override
  Widget build(BuildContext context) {
    UserInfoData userInfo = ref.watch(userInfoProvider);
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).padding.top, vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RepaintBoundary(
                    key: repaintKey,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        matchTextDirection: true,
                        repeat: ImageRepeat.noRepeat,
                        image: AssetImage(AppImagePath.shareBackground),
                      )),
                      child: _buildShareImg(userInfo),
                    )),
                SizedBox(height: UIDefine.getPixelWidth(5)),
                LoginButtonWidget(btnText: "cancel", onPressed: ()=>BaseViewModel().popPage(context))
              ],
            )));
  }

  Widget _buildSpace() {
    return SizedBox(height: UIDefine.getScreenHeight(1.5));
  }


  Widget _buildShareImg(UserInfoData userInfo) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(children: [
        Image.asset(AppImagePath.mainAppBarLogo,
            height: UIDefine.getScreenHeight(5), fit: BoxFit.fitHeight),
      ]),
      _buildSpace(),
      Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: UIDefine.getPixelWidth(30)),
              Container(
                decoration: AppStyle().styleColorsRadiusBackground(),
                padding: EdgeInsets.symmetric(
                    vertical: UIDefine.getPixelWidth(5),
                    horizontal: UIDefine.getPixelWidth(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildUserInfo(userInfo),
                    // _buildOrderTitle(),
                    // _buildOrderInfo(),
                    SizedBox(height: UIDefine.getPixelWidth(10))
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              top: UIDefine.getPixelWidth(5),
              left: UIDefine.getPixelWidth(10),
              child: _buildUserIcon(userInfo)),
        ],
      ),
      _buildShareCode(userInfo),
    ]);
  }
  Widget _buildUserIcon(UserInfoData userInfo) {
    double iconHeight = UIDefine.getPixelWidth(60);
    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(radius: 60),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      child: userInfo.photoUrl.isNotEmpty
          ? CircleNetworkIcon(
          showNormal: true,
          networkUrl: userInfo.photoUrl,
          radius: iconHeight / 2)
          : Image.asset(AppImagePath.avatarImg,
          width: iconHeight, height: iconHeight),
    );
  }
  Widget _buildUserInfo(UserInfoData userInfo) {
    return Padding(
      padding: EdgeInsets.only(
          top: UIDefine.getPixelWidth(10),
          bottom: UIDefine.getPixelWidth(30),
          left: UIDefine.getPixelWidth(80)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          userInfo.name,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
        ),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        LevelIconWidget(
            level: userInfo.level, size: UIDefine.getPixelWidth(20)),
        SizedBox(width: UIDefine.getPixelWidth(5)),
        userInfo.medal.isNotEmpty
            ? MedalIconWidget(
          medal: userInfo.medal,
          size: UIDefine.getPixelWidth(20),
        )
            : const SizedBox()
      ]),
    );
  }

  Widget _buildShareCode(UserInfoData userInfo) {
    double itemSize = UIDefine.getWidth() * 0.25;
    String link =
        '${GlobalData.urlPrefix}#/uc/register/?inviteCode=${userInfo.inviteCode}';
    return Column(mainAxisSize: MainAxisSize.min, children: [
      // SizedBox(
      //     width: UIDefine.getWidth() * 0.75,
      //     child: const Divider(
      //       thickness: 0.5,
      //       color: Colors.white,
      //     )),
      _buildSpace(),
      SizedBox(
          width: UIDefine.getWidth(),
          height: itemSize,
          child: Row(children: [
            Container(
              decoration: AppStyle().styleColorBorderBackground(
                  color: Colors.white,
                  backgroundColor: Colors.transparent,
                  radius: 3),
              child: QrImage(
                  errorStateBuilder: (context, error) => Text(error.toString()),
                  data: link,
                  version: QrVersions.auto,
                  size: itemSize,
                  foregroundColor: AppColors.mainThemeButton),
            ),
            SizedBox(width: UIDefine.getScreenWidth(3)),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr('inviteCode'),
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textSixBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: UIDefine.fontSize10)),
                  Text(userInfo.inviteCode,
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: UIDefine.fontSize18))
                ])
          ])),
      _buildSpace()
    ]);
  }
}
