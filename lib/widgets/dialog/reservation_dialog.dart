import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/widgets/dialog/base_close_dialog.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../button/action_button_widget.dart';
import '../label/level_detail.dart';

class ReservationDialog extends BaseCloseDialog {
  ReservationDialog(super.context,
      {super.backgroundColor = Colors.transparent,
      required this.confirmBtnAction});

  VoidCallback confirmBtnAction;

  @override
  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          tr('reserve'),
          style: TextStyle(
              fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('numberAppointments'),style: TextStyle(fontSize: UIDefine.fontSize14),),
            const SizedBox(
              height: 5,
            ),
            TextField(
             enabled: false,
              decoration: InputDecoration(
                hintText: '1',
                  hintStyle: const TextStyle(color: AppColors.textGrey),
                  border: AppStyle().styleTextEditBorderBackground(radius: 10),
                  filled: true,
                  fillColor: AppColors.textWhite,
                  contentPadding: const EdgeInsets.only(
                      left: 14.0, bottom: 8.0, top: 8.0)),
            ),
            Wrap(
              runAlignment: WrapAlignment.start,
             children: [
               LevelDetailLabel(
                 title: tr('reservationAmount'),
                 showCoins: false,
                 content: '1',
                 rightFontWeight: FontWeight.bold,
               ),
               LevelDetailLabel(
                 title: tr('availableBalance'),
                 showCoins: true,
                 content: '10,000 U',
                 rightFontWeight: FontWeight.bold,
               ),
               LevelDetailLabel(
                 title: tr('reservationFee'),
                 showCoins: true,
                 content: '10 U',
                 rightFontWeight: FontWeight.bold,
               ),
               LevelDetailLabel(
                 title: tr('transactionHour'),
                 showCoins: false,
                 content: 'T + 1',
                 rightFontWeight: FontWeight.bold,
               ),
               LevelDetailLabel(
                 title: tr('transactionReward'),
                 showCoins: false,
                 content: '2%',
                 rightFontWeight: FontWeight.bold,
               ),
             ],
            )
          ],
        ),
        ActionButtonWidget(
          btnText: tr('check'),
          onPressed: confirmBtnAction,
          margin: EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 6),
        ),
      ],
    );
  }
}
