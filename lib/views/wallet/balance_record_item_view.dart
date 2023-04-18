import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import 'data/BalanceRecordResponseData.dart';

class BalanceRecordItemView extends StatelessWidget {
  const BalanceRecordItemView({super.key, required this.data});

  final BalanceRecordResponseData data;

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
                Text(
                  _getTitle(),
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 3),
                Text(
                  BaseViewModel().changeTimeZone(data.time,
                      strFormat: 'yyyy-MM-dd HH:mm:ss'),
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textNineBlack,
                      fontSize: UIDefine.fontSize12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              _getAmount(),
              style: AppTextStyle.getBaseStyle(
                  color: _getColor(),
                  fontSize: UIDefine.fontSize16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),

        // SizedBox(height: UIDefine.getScreenWidth(5.5)),
        // Container(width: double.infinity, height: 1, color: AppColors.searchBar),
        // SizedBox(height: UIDefine.getScreenWidth(5.5))
      ],
    );
  }

  String _getIcon() {
    if (data.amount > 0) {
      return AppImagePath.myRechargeIcon;
    } else {
      return AppImagePath.myWithdrawIcon;
    }
  }

  ///BSC; TRON;
  ///TRANSFER(轉帳);
  /// MANUAL(手動);
  /// CUSTOMER(外部轉入);
  /// INTERNAL(內部轉帳);
  /// OTHER(轉出)
  /// ACTIVITY_AWARD(活動獎勵)
  /// EXPERIENCE_ADD(體驗金增加)
  /// EXPERIENCE_RECYCLE(體驗金回收)
  /// FLAT(法幣充值)
  String _getTitle() {
    if (data.type == 'ACTIVITY_AWARD') {
      return tr('ACTIVITY_AWARD');
    }

    bool bDeposit = true;
    if (data.amount < 0) {
      // 提領
      bDeposit = false;
    }

    switch (data.type) {
      case 'FLAT':
        return tr("fiatCurrencyRecharge");
      case 'BSC':
        return bDeposit ? tr("rechargeUSDT-BSC'") : tr("depositUSDT-BSC'");
      case 'TRON':
        return bDeposit ? tr("rechargeUSDT-TRON'") : tr("depositUSDT-TRON'");
      case 'TRANSFER':
        return bDeposit
            ? tr("rechargeUSDT-MANUAL'")
            : tr("depositUSDT-TRANSFER'"); // 應是沒有充值USDT但轉帳Type, 寫上去只是預防
      case 'MANUAL':
      case 'CUSTOMER':
      case 'INTERNAL':
      case 'OTHER':
        return bDeposit ? tr("rechargeUSDT-MANUAL'") : tr("withdrawUsdt");
      default:
        return tr(data.type);
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
      return AppColors.rateGreen;
    } else {
      return AppColors.rateRed;
    }
  }
}
