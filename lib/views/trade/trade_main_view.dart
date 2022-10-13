import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:treasure_nft_project/constant/enum/level_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/trade/trade_main_viewmodel.dart';
import 'package:treasure_nft_project/widgets/count_down_timer.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/animation_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/base_close_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/custom_amount_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/reservation_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/trade_rule_dialot.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';
import '../../constant/theme/app_image_path.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/label/level_detail.dart';
import '../../widgets/list_view/trade/level_area_list_view_cell.dart';

class TradeMainView extends StatefulWidget {
  const TradeMainView({Key? key}) : super(key: key);

  @override
  State<TradeMainView> createState() => _TradeMainViewState();
}

class _TradeMainViewState extends State<TradeMainView> {
  late TradeMainViewModel viewModel;

  @override
  void initState() {
    viewModel = TradeMainViewModel(setState: setState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const DomainBar(),
          _countDownView(context),
          _levelView(context),
          _levelArea(context)
        ],
      ),
    );
  }

  Widget _countDownView(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          AppImagePath.countDownBackground,
          width: UIDefine.getWidth(),
          height: UIDefine.getWidth(),
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(top: UIDefine.getHeight() / 25),
          width: UIDefine.getWidth() / 1.1,
          height: UIDefine.getWidth() / 1.3,
          decoration: AppStyle().styleColorBorderBackground(
              color: Colors.white,
              backgroundColor: Colors.transparent,
              borderLine: 2),
        ),
        Container(
          margin: EdgeInsets.only(top: UIDefine.getHeight() / 25),
          width: UIDefine.getWidth() / 1.2,
          height: UIDefine.getWidth() / 1.45,
          decoration: AppStyle().styleColorsRadiusBackground(
              color: Colors.white.withOpacity(0.5)),
        ),
        Positioned(
          top: UIDefine.getHeight() / 8,
          child: Column(
            children: [
              Image.asset(
                AppImagePath.clockBlue,
                width: UIDefine.getWidth() / 3.6,
                height: UIDefine.getWidth() / 3.6,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: UIDefine.getHeight() / 40,
              ),
              CountDownTimer(),
              LoginButtonWidget(
                width: UIDefine.getWidth() / 1.7,
                height: UIDefine.getHeight() / 20,
                btnText: '(GMT + 8)00 : 23 : 00 PM',
                fontSize: UIDefine.fontSize14,
                onPressed: () {},
              )
            ],
          ),
        ),
        _ruleAction(context)
      ],
    );
  }

  Widget _ruleAction(BuildContext context) {
    return Positioned(
        top: 10,
        right: 10,
        child: InkWell(
          onTap: () {
            TradeRuleDialog(context).show();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: UIDefine.getWidth() / 6.5,
                  height: UIDefine.getHeight() / 25,
                  decoration: AppStyle().styleColorBorderBackground(
                    radius: 7,
                    color: Colors.black,
                    backgroundColor: Colors.transparent,
                    borderLine: 2,
                  )),
              Text(
                tr('trade-rules'),
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14),
              )
            ],
          ),
        ));
  }

  Widget _levelView(BuildContext context) {
    TextStyle titleStyle = TextStyle(fontSize: UIDefine.fontSize16);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: UIDefine.getHeight() / 30,
          horizontal: UIDefine.getWidth() / 20),
      child: Column(
        children: [
          Row(children: [
            Image.asset(
              getLevelImg(LevelRank.LEVEL0),
              width: UIDefine.getWidth() / 11,
              height: UIDefine.getWidth() / 11,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(tr('level'), style: titleStyle),
            const SizedBox(
              width: 5,
            ),
            Text(
              '1',
              style: titleStyle,
            )
          ]),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              LevelDetailLabel(
                title: tr('reserveCount'),
                content: '999',
                rightFontWeight: FontWeight.bold,
              ),
              LevelDetailLabel(
                title: tr("wallet-balance'"),
                showCoins: true,
                content: '${viewModel.info?.balance}',
                rightFontWeight: FontWeight.bold,
              ),
              LevelDetailLabel(
                title: tr('amountRangeNFT'),
                showCoins: true,
                content: '0~99,999',
                rightFontWeight: FontWeight.bold,
              ),
              const Divider(
                color: AppColors.dialogGrey,
                thickness: 1,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _levelArea(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 20),
        child: Column(
          children: [
            LevelListViewCell(
              reservationAction: () {
                ReservationDialog(context, confirmBtnAction: () {
                  Navigator.pop(context);
                  AnimationDialog(context, AppAnimationPath.reserveSuccess)
                      .show();
                }).show();
              },
            )
          ],
        ));
  }

  getLevelImg(LevelRank level) {
    switch (level) {
      case LevelRank.LEVEL0:
        return AppImagePath.level0;
      case LevelRank.LEVEL1:
        return AppImagePath.level1;
      case LevelRank.LEVEL2:
        return AppImagePath.level2;
      case LevelRank.LEVEL3:
        return AppImagePath.level3;
      case LevelRank.LEVEL4:
        return AppImagePath.level4;
      case LevelRank.LEVEL5:
        return AppImagePath.level5;
      case LevelRank.LEVEL6:
        return AppImagePath.level6;
      case LevelRank.LEVEL7:
        return AppImagePath.level7;
      case LevelRank.LEVEL8:
        return AppImagePath.level8;
      case LevelRank.LEVEL9:
        return AppImagePath.level9;
      case LevelRank.LEVEL10:
        return AppImagePath.level10;
    }
  }
}
