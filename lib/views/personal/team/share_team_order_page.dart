import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../constant/global_data.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/team_order.dart';
import '../../../view_models/gobal_provider/user_info_provider.dart';
import '../../../view_models/personal/team/share_team_order_viewmodel.dart';
import '../../../widgets/button/action_button_widget.dart';
import '../../../widgets/label/icon/level_icon_widget.dart';
import '../../../widgets/label/icon/medal_icon_widget.dart';
import '../../login/circle_network_icon.dart';

class ShareTeamOrderPage extends ConsumerStatefulWidget {
  const ShareTeamOrderPage(
      {Key? key, required this.itemData, this.fromSell = false})
      : super(key: key);

  final TeamOrderData itemData;
  final bool fromSell;

  @override
  ConsumerState createState() => _ShareTeamOrderPageState();
}

class _ShareTeamOrderPageState extends ConsumerState<ShareTeamOrderPage> {
  late ShareTeamOrderViewModel viewModel;

  TeamOrderData get itemData {
    return widget.itemData;
  }

  bool get fromSell {
    return widget.fromSell;
  }

  @override
  void initState() {
    super.initState();
    viewModel = ShareTeamOrderViewModel(onViewUpdate: () {
      if (mounted) {
        setState(() {});
      }
    }, onShareFinish: () {
      viewModel.popPage(context);
    });
    viewModel.initState(itemData, fromSell);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoData userInfo = ref.watch(userInfoProvider);
    return Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).padding.top, vertical: 0),
            child: RepaintBoundary(
                key: viewModel.repaintKey,
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
                ))));
  }

  Widget _buildSpace() {
    return SizedBox(height: UIDefine.getScreenHeight(1.5));
  }

  Widget _buildShareImg(UserInfoData userInfo) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _buildUserInfo(userInfo),
      _buildOrderTitle(),
      _buildOrderInfo(),
      _buildShareCode(userInfo),
    ]);
  }

  Widget _buildUserInfo(UserInfoData userInfo) {
    double iconHeight = UIDefine.getScreenHeight(10);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(children: [
        Image.asset(AppImagePath.mainAppBarLogo,
            height: UIDefine.getScreenHeight(5), fit: BoxFit.fitHeight),
      ]),
      _buildSpace(),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        userInfo.photoUrl.isNotEmpty
            ? CircleNetworkIcon(
                showNormal: true,
                networkUrl: userInfo.photoUrl,
                radius: iconHeight / 2)
            : Image.asset(AppImagePath.avatarImg,
                width: iconHeight, height: iconHeight),
        SizedBox(width: UIDefine.getScreenWidth(5)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            userInfo.name,
            style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize12),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ActionButtonWidget(
                setHeight: UIDefine.fontSize24,
                fontSize: UIDefine.fontSize14,
                isFillWidth: false,
                btnText: 'Level ${userInfo.level}',
                radius: 5,
                onPressed: () {}),
            const SizedBox(width: 10),
            LevelIconWidget(level: userInfo.level, size: UIDefine.fontSize24),
            const SizedBox(width: 5),
            userInfo.medal.isNotEmpty
                ? MedalIconWidget(
                    medal: userInfo.medal,
                    size: UIDefine.fontSize24,
                  )
                : Container()
          ])
        ])
      ]),
      _buildSpace(),
    ]);
  }

  Widget _buildOrderTitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(fromSell ? tr('myTradingResults') : tr('myReward')),
            Text(
                '${tr('tradingCycle')} : ${viewModel.teamShareInfo?.day ?? '0'}${tr('day')}')
          ],
        ),
        SizedBox(
            width: UIDefine.getWidth() * 0.75,
            child: const Divider(
              thickness: 0.5,
              color: Colors.black,
            )),
        _buildSpace(),
      ],
    );
  }

  Widget _buildOrderInfo() {
    double itemSize = UIDefine.getWidth() * 0.3;
    TextStyle titleStyle = AppTextStyle.getBaseStyle(
        color: AppColors.dialogGrey,
        fontWeight: FontWeight.w500,
        fontSize: UIDefine.fontSize12);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
          height: itemSize,
          width: UIDefine.getWidth(),
          child: Row(children: [
            GraduallyNetworkImage(
              imageUrl: itemData.imgUrl,
              height: itemSize,
              width: itemSize,
              fit: BoxFit.contain,
            ),
            Expanded(
                child: Column(children: [
              SizedBox(height: itemSize * 0.05),
              Text(fromSell ? tr("profit-loss-ratio'") : tr('promotionReward'),
                  style: titleStyle),
              _buildSpace(),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Text(
                    fromSell
                        ? '${NumberFormatUtil().removeTwoPointFormat(viewModel.teamShareInfo?.profitPCT ?? 0)}%'
                        : '${NumberFormatUtil().removeTwoPointFormat(viewModel.teamShareInfo?.promotePct ?? 0)}%',
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.mainThemeButton,
                        fontSize: UIDefine.fontSize28,
                        fontWeight: FontWeight.w500)),
              )),
              SizedBox(height: itemSize * 0.3)
            ])),
            Expanded(
                child: Column(children: [
              SizedBox(height: itemSize * 0.05),
              Text(
                  fromSell
                      ? tr("accumulated-profit-loss'")
                      : tr('promotionIncome'),
                  style: titleStyle),
              _buildSpace(),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    TetherCoinWidget(size: UIDefine.fontSize22),
                    const SizedBox(width: 5),
                    Text(
                        NumberFormatUtil()
                            .removeTwoPointFormat(itemData.income),
                        style: AppTextStyle.getBaseStyle(
                            color: AppColors.textBlack,
                            fontSize: UIDefine.fontSize16,
                            fontWeight: FontWeight.w500))
                  ])),
              SizedBox(height: itemSize * 0.3)
            ]))
          ])),
      _buildSpace()
    ]);
  }

  Widget _buildShareCode(UserInfoData userInfo) {
    double itemSize = UIDefine.getWidth() * 0.25;
    String link =
        '${GlobalData.urlPrefix}#/uc/register/?inviteCode=${userInfo.inviteCode}';
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
          width: UIDefine.getWidth() * 0.75,
          child: const Divider(
            thickness: 0.5,
            color: Colors.white,
          )),
      _buildSpace(),
      SizedBox(
          width: UIDefine.getWidth(),
          height: itemSize,
          child: Row(children: [
            QrImage(
                errorStateBuilder: (context, error) => Text(error.toString()),
                data: link,
                version: QrVersions.auto,
                size: itemSize,
                foregroundColor: AppColors.textBlack),
            SizedBox(width: UIDefine.getScreenWidth(3)),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tr('inviteCode'),
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.dialogGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: UIDefine.fontSize12)),
                  Text(userInfo.inviteCode,
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.dialogBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: UIDefine.fontSize16))
                ])
          ])),
      _buildSpace()
    ]);
  }
}
