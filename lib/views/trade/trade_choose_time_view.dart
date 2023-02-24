import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/check_reservation_info.dart';
import '../../models/http/parameter/check_reserve_deposit.dart';
import '../../models/http/parameter/trade_reserve_stage__info.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../utils/app_text_style.dart';
import '../../utils/date_format_util.dart';
import '../../utils/number_format_util.dart';
import '../../utils/trade_timer_util.dart';
import '../../view_models/gobal_provider/user_info_provider.dart';
import '../../view_models/trade/provider/trade_reserve_coin_provider.dart';
import '../../view_models/trade/provider/trade_reserve_info_provider.dart';
import '../../view_models/trade/provider/trade_reserve_stage_provider.dart';
import '../../widgets/button/login_button_widget.dart';
import '../../widgets/label/coin/tether_coin_widget.dart';

class TradeChooseTimeView extends ConsumerStatefulWidget {
  const TradeChooseTimeView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TradeChooseTimeViewState();
}

class _TradeChooseTimeViewState extends ConsumerState<TradeChooseTimeView> {
  List<TradeReserveStageInfo> get reserveStages {
    return ref.read(tradeReserveStageProvider);
  }

  CheckReserveDeposit? get reserveCoin {
    return ref.read(tradeReserveCoinProvider);
  }

  CheckReservationInfo? get reserveInfo {
    return ref.read(tradeReserveInfoProvider);
  }
  UserInfoData get userInfo {
    return ref.read(userInfoProvider);
  }

  @override
  void initState() {
    ref.read(tradeReserveStageProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(tradeReserveStageProvider);

    return Scaffold(
      body: _buildTimeStageView(),
    );
  }

  ///MARK: 區間選擇
  Widget _buildTimeStageView() {
    return Container(
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
      child: Column(
        children: [
          Container(
              decoration: AppStyle().styleColorBorderBackground(
                  borderLine: 0.5,
                  radius: 6,
                  backgroundColor: const Color(0xFFF5F8FB),
                  color: AppColors.textSixBlack),
              padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(tr('selectionPeriod'),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: UIDefine.getPixelWidth(20)),
                _buildDateState(
                    title: tr('appTodayReserve'),
                    titleColor: const Color(0xFF1F64E5),
                    date: DateFormatUtil().getTimeWithDayFormat()),
                _buildDateState(
                    title: tr('appTomorrowReserve'),
                    titleColor: const Color(0xFF1F64E5),
                    date: DateFormatUtil().getAfterDays(1)),
              ])),
          SizedBox(height: UIDefine.getPixelWidth(10)),

          ///MARK: 顯示交易區間的資訊
          _buildDivisionInfo(),
        ],
      ),
    );
  }

  bool checkReserve(DateTime startTime) {
    ///MARK: 判斷場次時間是否已過
    if (DateTime.now().isBefore(startTime)) {
      if (reserveInfo != null) {
        String localTime = reserveInfo!.localTime;
        String reserveStartTime = reserveInfo!.reserveStartTime;
        String reserveEndTime = reserveInfo!.reserveEndTime;
        // GlobalData.printLog('localTime:$localTime');
        // GlobalData.printLog('reserveStartTime:$reserveStartTime');
        // GlobalData.printLog('reserveEndTime:$reserveEndTime');

        ///MARK: 跨日計算
        return !(localTime.compareTo(reserveEndTime) > 0 &&
            localTime.compareTo(reserveStartTime) <= 0);
      }
    }
    return false;
  }

  Widget _buildDateState(
      {required String title,
      required Color titleColor,
      required String date}) {
    List<Widget> list = [];
    for (int index = 0; index < reserveStages.length; index++) {
      TradeReserveStageInfo info = reserveStages[index];
      if (DateFormatUtil()
              .getTimeWithDayFormat(time: info.startTime)
              .compareTo(date) ==
          0) {
        list.add(_buildStageItem(index));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
          child: Text(title,
              style: AppTextStyle.getBaseStyle(
                  color: titleColor,
                  fontSize: UIDefine.fontSize14,
                  fontWeight: FontWeight.w400)),
        ),
        ...list
      ],
    );
  }

  Widget _buildStageItem(int index) {
    TradeReserveStageInfo info = reserveStages[index];

    ///MARK: isAvailable 都顯示 false
    bool canReserve = info.isAvailable ? checkReserve(info.startTime) : false;
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleColorBorderBackground(
          borderLine: 0.4,
          radius: 20,
          backgroundColor: Colors.white,
          color: const Color(0xFFC6CACC)),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('appReservation'),
              style: AppTextStyle.getBaseStyle(
                color: AppColors.textSixBlack,
                fontSize: UIDefine.fontSize12,
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${DateFormatUtil().buildFormat(strFormat: 'HH:mm', time: info.startTime)} ~'
                    '${DateFormatUtil().buildFormat(strFormat: 'HH:mm', time: info.endTime)}'
                    '\n(${userInfo.zone})',
                    textAlign: TextAlign.start,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                    color: const Color(0xFFEFEFEF),
                    width: 1,
                    height: UIDefine.fontSize16),
                Expanded(
                  child: Text(
                    '${NumberFormatUtil().removeTwoPointFormat(info.reserveBalance)}'
                    '\n${tr('balanceReservation')}',
                    textAlign: TextAlign.end,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSixBlack),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: LoginButtonWidget(
                height: UIDefine.getPixelWidth(40),
                padding:
                    EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w600,
                btnText: tr('reserve'),
                onPressed: () {
                  if (canReserve) {
                    ref.read(tradeCurrentStageProvider.notifier).state = index;
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _buildDivisionInfo() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _buildDivisionInfoItem(
          title: tr('reservationTime'),
          context: TradeTimerUtil().getReservationTime()),
      _buildDivisionInfoItem(
          title: tr('NFTResultTime'),
          context: TradeTimerUtil().getResultTime()),
      _buildDivisionInfoItem(
          title: tr('reservationFee'),
          context: NumberFormatUtil().integerFormat(reserveCoin?.deposit ?? 0)),
      _buildDivisionInfoItem(
          title: tr('transactionReward'),
          context:
          '${NumberFormatUtil().removeTwoPointFormat(reserveCoin?.reward ?? 0)} %'),
    ]);
  }

  Widget _buildDivisionInfoItem(
      {required String title, required String context, bool needCoin = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Row(
        children: [
          Text(title,
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: UIDefine.fontSize14)),
          const Spacer(),
          Visibility(
              visible: needCoin,
              child: TetherCoinWidget(size: UIDefine.getPixelWidth(12))),
          SizedBox(width: UIDefine.getPixelWidth(5)),
          Text(context,
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: UIDefine.fontSize14)),
        ],
      ),
    );
  }

}
