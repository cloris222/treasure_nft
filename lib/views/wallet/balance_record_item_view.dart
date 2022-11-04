import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import 'data/BalanceRecordResponseData.dart';

class BalanceRecordItemView extends StatelessWidget {
  BalanceRecordItemView({super.key, required this.data});


  BalanceRecordResponseData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(_getIcon()),

                    Text(
                      _getTitle(),
                      style: TextStyle(fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  data.time,
                  style: TextStyle(color: AppColors.dialogGrey,
                      fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            Text(
              _getAmount(),
              style: TextStyle(color: _getColor(),
                  fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
            ),
          ],
        ),

        SizedBox(height: UIDefine.getScreenWidth(5.5)),
        Container(width: double.infinity, height: 1, color: AppColors.searchBar),
        SizedBox(height: UIDefine.getScreenWidth(5.5))
      ],
    );
  }

  String _getIcon() {
    if (data.amount > 0) {
      return 'assets/icon/icon/icon_card_03.png';
    } else {
      return 'assets/icon/icon/icon_extraction_04.png';
    }
  }

  String _getTitle() {
    if (data.type == 'ACTIVITY_AWARD') {
      return tr('ACTIVITY_AWARD');
    }

    bool bDeposit = true;
    if (data.amount < 0) { // 提領
      bDeposit = false;
    }

    switch(data.type) {
      case 'BSC':
        return bDeposit ? tr("rechargeUSDT-BSC'") : tr("depositUSDT-BSC'");
      case 'TRON':
        return bDeposit ? tr("rechargeUSDT-TRON'") : tr("depositUSDT-TRON'");
      case 'TRANSFER':
        return bDeposit ? tr("rechargeUSDT-MANUAL'") : tr("depositUSDT-TRANSFER'"); // 應是沒有充值USDT但轉帳Type, 寫上去只是預防
      case 'MANUAL':
      case 'CUSTOMER':
      case 'INTERNAL':
      case 'OTHER':
        return bDeposit ? tr("rechargeUSDT-MANUAL'") : tr("withdrawUsdt");
    }

    return '';
  }

  String _getAmount() {
    if (data.amount > 0) {
      return '+${data.amount}';
    }
    return data.amount.toString();
  }

  Color _getColor() {
    if (data.amount > 0) {
      return AppColors.growPrice;
    } else {
      return AppColors.textRed;
    }
  }

}