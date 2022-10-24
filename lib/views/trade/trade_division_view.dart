import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/level_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/data/trade_model_data.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';
import 'package:treasure_nft_project/widgets/count_down_timer.dart';
import 'package:treasure_nft_project/widgets/dialog/animation_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/reservation_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/success_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/trade_rule_dialot.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/parameter/check_reservation_info.dart';
import '../../utils/date_format_util.dart';
import '../../view_models/trade/trade_division_viewmodel.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/dialog/simple_custom_dialog.dart';
import '../../widgets/label/level_detail.dart';
import '../../widgets/list_view/trade/level_area_division_cell.dart';

class TradeDivisionView extends StatefulWidget {
  const TradeDivisionView({
    Key? key,
    required this.level,
  }) : super(key: key);

  final int level;

  @override
  State<TradeDivisionView> createState() => _TradeDivisionViewState();
}

class _TradeDivisionViewState extends State<TradeDivisionView> {
  late TradeDivisionViewModel viewModel;

  @override
  void initState() {
    viewModel = TradeDivisionViewModel(setState: () {
      if (mounted) {
        setState(() {});
      }
    },

        /// 預約成功
        reservationSuccess: () {
      AnimationDialog(context, AppAnimationPath.reserveSuccess).show();

      /// hide reservation button
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
    }, errorMes: (errorCode) {
      SimpleCustomDialog(context, mainText: tr(errorCode), isSuccess: false)
          .show();
    });
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
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        Navigator.pop(context);
      }, widget.level == 0 ? tr('noviceArea') : 'Level ${widget.level}'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _countDownView(context),
            _levelView(context),
            checkDataInit()
          ],
        ),
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
          Column(
            children: [
              LevelDetailLabel(
                title: tr('reserveCount'),
                content: '${viewModel.reservationInfo?.reserveCount}',
                rightFontWeight: FontWeight.bold,
              ),
              LevelDetailLabel(
                title: tr('amountRangeNFT'),
                showCoins: true,
                content: viewModel.getRange(),
                rightFontWeight: FontWeight.bold,
              ),
              LevelDetailLabel(
                title: tr("wallet-balance'"),
                showCoins: true,
                content:
                    '${viewModel.reservationInfo?.balance.toStringAsFixed(2)}',
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

  Widget checkDataInit() {
    if (viewModel.reservationInfo != null) {
      return _levelArea(context);
    } else {
      return Container();
    }
  }

  Widget _levelArea(BuildContext context) {
    return ListView.builder(
        itemCount: viewModel.reservationInfo?.reserveRanges.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return DivisionCell(
            /// press btn check reservation info
            reservationAction: () {
              ReserveRange? range = viewModel.ranges[index];
              ReservationDialog(context, confirmBtnAction: () async {
                Navigator.pop(context);

                /// add new reservation
                await viewModel.addNewReservation(index);

                /// if reservation success 預約狀態 = true
                viewModel.ranges[index].used = true;

                /// 狀態更新
                setState(() {});
              },
                      index: range.index,
                      startPrice: range.startPrice.toDouble(),
                      endPrice: range.endPrice.toDouble())
                  .show();
            },
            range: viewModel.ranges[index], level: widget.level,
          );
        });
  }
}