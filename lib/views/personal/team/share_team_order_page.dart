import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:treasure_nft_project/models/http/parameter/user_info_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../constant/global_data.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/theme/app_style.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/team_order.dart';
import '../../../view_models/gobal_provider/user_info_provider.dart';
import '../../../view_models/personal/team/share_team_order_viewmodel.dart';
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
                    _buildOrderTitle(),
                    _buildOrderInfo(),
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

  Widget _buildOrderTitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              fromSell ? tr('myTradingResults') : tr('myReward'),
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w600),
            )),
            Expanded(
              child: Text(
                '${tr('tradingCycle')} : ${viewModel.teamShareInfo?.day ?? '0'}${tr('day')}',
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textNineBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: UIDefine.fontSize10),
              ),
            )
          ],
        ),
        _buildSpace(),
      ],
    );
  }

  Widget _buildOrderInfo() {
    double itemSize = UIDefine.getWidth() * 0.3;

    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Container(
          constraints: BoxConstraints(maxWidth: UIDefine.getWidth() * 0.7),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GraduallyNetworkImage(
              imageUrl: itemData.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
     
      Container(
        constraints: BoxConstraints(minWidth: UIDefine.getPixelWidth(100)),
        margin: EdgeInsets.only(left: UIDefine.getPixelWidth(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildReward(itemSize),
            SizedBox(height: UIDefine.getPixelWidth(5)),
            _buildIncome(itemSize),
          ],
        ),
      ),
    ]);
  }

  Widget _buildReward(double itemSize) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: itemSize * 0.05),
          Text(fromSell ? tr("profit-loss-ratio'") : tr('promotionReward'),
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: UIDefine.fontSize10)),
          Container(
            alignment: Alignment.center,
            child: GradientThirdText(
              fromSell
                  ? '${NumberFormatUtil().removeTwoPointFormat(viewModel.teamShareInfo?.profitPCT ?? 0)}%'
                  : '${NumberFormatUtil().removeTwoPointFormat(viewModel.teamShareInfo?.promotePct ?? 0)}%',
              size: UIDefine.fontSize30,
              weight: FontWeight.w600,
            ),
          ),
        ]);
  }

  Widget _buildIncome(double itemSize) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: itemSize * 0.05),
          Text(
              fromSell ? tr("accumulated-profit-loss'") : tr('promotionIncome'),
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w500,
                  fontSize: UIDefine.fontSize10)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TetherCoinWidget(size: UIDefine.getPixelWidth(18)),
            const SizedBox(width: 5),
            Text(NumberFormatUtil().removeTwoPointFormat(itemData.income),
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack,
                    fontSize: UIDefine.fontSize16,
                    fontWeight: FontWeight.w500))
          ]),
        ]);
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
