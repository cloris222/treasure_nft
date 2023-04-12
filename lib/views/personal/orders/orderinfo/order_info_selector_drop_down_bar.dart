import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../../constant/enum/order_enum.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../../constant/theme/app_theme.dart';
import '../../../../constant/ui_define.dart';

class OrderInfoSelectorDropDownBar extends StatelessWidget {
  const OrderInfoSelectorDropDownBar(
      {super.key, required this.getDropDownValue, this.bFromWallet = false});

  final Function(OrderInfoType type) getDropDownValue;
  final bool bFromWallet;

  @override
  Widget build(BuildContext context) {
    return _dropDownBar();
  }

  Widget _dropDownBar() {
    return DropdownButtonFormField(
      icon: Image.asset('assets/icon/btn/btn_arrow_02_down.png'),
      onChanged: (newValue) {
        getDropDownValue(newValue!);
      },
      value: bFromWallet ? OrderInfoType.DEPOSIT : OrderInfoType.BUY,
      // index 4是充值
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
            UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.5),
            UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(0.5)),
        border: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.bolderGrey, radius: 8, width: 1),
        focusedBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.bolderGrey, radius: 8, width: 1),
        enabledBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.bolderGrey, radius: 8, width: 1),
      ),
      items: OrderInfoType.values.map((OrderInfoType category) {
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(_getCategoryText(category),
                    style:
                        AppTextStyle.getBaseStyle(color: AppColors.textGrey)),
              ],
            ));
      }).toList(),
    );
  }

  String _getCategoryText(OrderInfoType value) {
    // 下拉選單 多國
    switch (value) {
      case OrderInfoType.BUY:
        return tr('buyer');
      case OrderInfoType.SELL:
        return tr('seller');
      case OrderInfoType.PRICE:
        return tr('copyReservation');
      case OrderInfoType.ACTIVITY:
        return tr('activitiesUSDT');
      case OrderInfoType.DEPOSIT:
        return tr('walletRecharge');
      case OrderInfoType.WITHDRAW:
        return tr('walletWithdraw');
      case OrderInfoType.ROYALTY:
        return tr('royalty');
      case OrderInfoType.DEPOSIT_NFT:
        return tr('depositNFT');
      case OrderInfoType.TRANSFER_NFT:
        return tr('transferOut');
      case OrderInfoType.TREASURE_BOX:
        return tr("appTypeAirdrop");
    }
  }
}
