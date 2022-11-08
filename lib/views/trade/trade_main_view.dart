import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/data/trade_model_data.dart';
import 'package:treasure_nft_project/widgets/count_down_timer.dart';
import 'package:treasure_nft_project/widgets/dialog/new_reservation_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/trade_rule_dialot.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';
import '../../constant/enum/trade_enum.dart';
import '../../constant/theme/app_animation_path.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/api/trade_api.dart';
import '../../models/http/parameter/check_reservation_info.dart';
import '../../models/http/parameter/check_reserve_deposit.dart';
import '../../utils/date_format_util.dart';
import '../../view_models/trade/trade_main_viewmodel.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/dialog/animation_dialog.dart';
import '../../widgets/dialog/reservation_dialog.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';
import '../../widgets/dialog/success_dialog.dart';
import '../../widgets/label/level_detail.dart';
import '../../widgets/list_view/trade/level_area_division_cell.dart';
import '../../widgets/list_view/trade/level_area_main_cell.dart';

class TradeMainView extends StatefulWidget {
  const TradeMainView({Key? key}) : super(key: key);

  @override
  State<TradeMainView> createState() => _TradeMainViewState();
}

class _TradeMainViewState extends State<TradeMainView> {
  late TradeMainViewModel viewModel;

  @override
  void initState() {
    viewModel = TradeMainViewModel(
      setState: () {
        if (mounted) {
          setState(() {});
        }
      },

      /// 預約成功
      reservationSuccess: () {
        AnimationDialog(context, AppAnimationPath.reserveSuccess).show();
      },

      /// 預約金不足
      bookPriceNotEnough: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'")
                // TODO 預約金不足 多國
                )
            .show();
      },

      /// 餘額不足
      notEnoughToPay: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0013'))
            .show();
      },

      /// 預約金額不符
      depositNotEnough: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0041'))
            .show();
      },
      errorMes: (errorCode) {
        SimpleCustomDialog(context, mainText: tr(errorCode), isSuccess: false)
            .show();
      },

      /// 體驗帳號狀態過期
      experienceExpired: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0057'))
            .show();
      },

      /// 體驗帳號狀態關閉
      experienceDisable: () {
        SuccessDialog(
          context,
          callOkFunction: () {},
          isSuccess: false,
          mainText: tr("reserve-failed'"),
        ).show();
      },

      /// 新手帳號交易天數到期
      beginnerExpired: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0069'))
            .show();
      },
    );

    viewModel.initState();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.disposeState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const DomainBar(),
          _countDownView(context),
          _levelView(context),
          checkDataInit()
        ],
      ),
    );
  }

  Widget _countDownView(BuildContext context) {
    TradeData tradeData = viewModel.countSellDate();

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
                tradeData.status == SellingState.NotYet
                    ? AppImagePath.clockBlue
                    : AppImagePath.clockRed,
                width: UIDefine.getWidth() / 3.6,
                height: UIDefine.getWidth() / 3.6,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: UIDefine.getHeight() / 50,
              ),
              viewModel.reservationInfo != null
                  ? tradeData.status == SellingState.Selling
                      ? Text(
                          tr('onSale'),
                          style: TextStyle(
                              color: AppColors.textRed,
                              fontSize: UIDefine.fontSize24,
                              fontWeight: FontWeight.w600),
                        )
                      : CountDownTimer(
                          duration: tradeData.duration,
                        )
                  : Container(),
              LoginButtonWidget(
                width: UIDefine.getWidth() / 1.7,
                height: UIDefine.getHeight() / 20,
                btnText: viewModel.startTime != null
                    ? '(${viewModel.reservationInfo?.zone}) ${DateFormatUtil().getDateWith12HourInSecondFormat(viewModel.startTime!)}'
                    : '',
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.bold,
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
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: AppStyle().styleColorBorderBackground(
              radius: 7,
              color: Colors.black,
              backgroundColor: Colors.transparent,
              borderLine: 2,
            ),
            child: Text(
              tr('trade-rules'),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14),
            ),
          ),
        ));
  }

  Widget _levelView(BuildContext context) {
    TextStyle titleStyle = TextStyle(fontSize: UIDefine.fontSize16);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: UIDefine.getWidth() / 30),
      child: Column(
        children: [
          Row(children: [
            Image.asset(
              viewModel.getLevelImg(),
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
              '${GlobalData.userInfo.level}',
              style: titleStyle,
            )
          ]),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: AppStyle().styleColorBorderBackground(
                color: AppColors.bolderGrey, borderLine: 2),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Column(
                  children: [
                    LevelDetailLabel(
                      title: tr("wallet-balance'"),
                      showCoins: false,
                      content:
                          '${viewModel.reservationInfo?.balance.toStringAsFixed(2)}',
                      rightFontWeight: FontWeight.bold,
                    ),
                    LevelDetailLabel(
                      title: tr("availableBalance"),
                      content: '${viewModel.reservationInfo?.reserveBalance.toStringAsFixed(2)}',
                      rightFontWeight: FontWeight.bold,
                    ),
                    LevelDetailLabel(
                      title: tr('amountRangeNFT'),
                      showCoins: false,
                      content: viewModel.getRange(),
                      rightFontWeight: FontWeight.bold,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget checkDataInit() {
    if (viewModel.reservationInfo != null) {
      return _levelArea(context);
    } else {
      return Container();
    }
  }

  Widget _levelArea(BuildContext context) {
    if (GlobalData.userInfo.level == 0) {
      return _levelZero(context);
    }
    return ListView.builder(
        itemCount: viewModel.division?.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return LevelMainCell(
            level: viewModel.division![index],
          );
        });
  }

  Widget _levelZero(BuildContext context) {
    TradeData tradeData = viewModel.countSellDate();
    return ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return DivisionCell(
            /// press btn check reservation info
            reservationAction: () async {
              /// 查詢預約金
              CheckReserveDeposit checkReserveDeposit;
              checkReserveDeposit = await TradeAPI().getCheckReserveDepositAPI(
                  viewModel.ranges[index].index,
                  viewModel.ranges[index].startPrice.toDouble(),
                  viewModel.ranges[index].endPrice.toDouble());

              /// 推透明頁面！！！
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return NewReservationPopUpView(
                      confirmBtnAction: () async {
                        Navigator.pop(context);

                        /// add new reservation
                        await viewModel.addNewReservation(index);

                        /// if reservation success 預約狀態 = true
                        viewModel.ranges[index].used = true;

                        /// 狀態更新
                        setState(() {});
                      },
                      reservationFee: '${checkReserveDeposit.deposit}',
                      transactionTime: '${checkReserveDeposit.tradingTime}',
                      transactionReward: '${checkReserveDeposit.reward}',
                    );
                  },

                  /// 透明頁一定要加
                  opaque: false));
            },
            range: viewModel.ranges[index],
            level: 0,
            tradeData: tradeData,
          );
        });
  }
}
