import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/view_models/trade/reservation_viewmodel.dart';
import 'package:treasure_nft_project/widgets/dialog/base_close_dialog.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../button/action_button_widget.dart';
import '../label/level_detail.dart';

class ReservationDialog extends BaseCloseDialog {
  ReservationDialog(super.context,
      {super.backgroundColor = Colors.transparent,
      required this.confirmBtnAction,
      this.index,
      this.startPrice,
      this.endPrice});

  VoidCallback confirmBtnAction;
  late ReservationViewModel reservationViewModel;
  final int? index;
  final double? startPrice;
  final double? endPrice;

  @override
  Future<void> initValue() async {
    reservationViewModel = ReservationViewModel();
    await reservationViewModel.initState(index,startPrice,endPrice);
  }

  @override
  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          tr('reserve'),
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('numberAppointments'),
              style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: '1',
                  hintStyle:  AppTextStyle.getBaseStyle(color: AppColors.textGrey),
                  border: AppStyle().styleTextEditBorderBackground(radius: 10),
                  filled: true,
                  fillColor: AppColors.textWhite,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0)),
            ),
            Wrap(
              runAlignment: WrapAlignment.start,
              children: [
                LevelDetailLabel(
                  title: tr('reserveCount'),
                  showCoins: false,
                  content: '1',
                  rightFontWeight: FontWeight.w500,
                ),
                LevelDetailLabel(
                  title: tr('availableBalance'),
                  showCoins: true,
                  content: reservationViewModel.checkReserve.reserveBalance > 0 ?
                  reservationViewModel.checkReserve.reserveBalance.toStringAsFixed(2)
                     :
                  '0',
                  rightFontWeight: FontWeight.w500,
                ),
                LevelDetailLabel(
                  title: tr('reservationFee'),
                  showCoins: true,
                  content: '${reservationViewModel.checkReserve.deposit}',
                  rightFontWeight: FontWeight.w500,
                ),
                LevelDetailLabel(
                  title: tr('transactionHour'),
                  showCoins: false,
                  content: '${reservationViewModel.checkReserve.tradingTime}',
                  rightFontWeight: FontWeight.w500,
                ),
                LevelDetailLabel(
                  title: tr('transactionReward'),
                  showCoins: false,
                  content: '${reservationViewModel.checkReserve.reward}%',
                  rightFontWeight: FontWeight.w500,
                ),
              ],
            )
          ],
        ),
        ActionButtonWidget(
          btnText: tr('check'),
          onPressed: confirmBtnAction,
          isFillWidth: false,
        ),
      ],
    );
  }
}
