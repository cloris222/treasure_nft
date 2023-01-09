import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../../constant/call_back_function.dart';
import '../../../../constant/theme/app_colors.dart';
import '../../../../constant/theme/app_theme.dart';
import '../../../../constant/ui_define.dart';

class OrderInfoSelectorDropDownBar extends StatelessWidget {
  OrderInfoSelectorDropDownBar({super.key, required this.getDropDownValue, this.bFromWallet = false});

  final onGetStringFunction getDropDownValue;
  final bool bFromWallet;

  final List<String> _currencies = [
    'BUY',
    'SELL',
    'PRICE',
    // 'ITEM', // 隱藏不做
    // '', // test 前端有兩個 轉移NFT / 轉出NFT ????
    // 'FEE', // 隱藏不做
    'ACTIVITY',
    'DEPOSIT',
    'WITHDRAW',
    'ROYALTY',
    'DEPOSIT_NFT',
    'TRANSFER_NFT',
  ];

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
      value: bFromWallet? _currencies[4] : _currencies.first, // index 4是充值
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.16),
            UIDefine.getScreenWidth(4.5), UIDefine.getScreenWidth(4.16), UIDefine.getScreenWidth(0.5)),
        border: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.datePickerBorder, radius: 10, width: 3),
        focusedBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.datePickerBorder, radius: 10, width: 3),
        enabledBorder: AppTheme.style.styleTextEditBorderBackground(
            color: AppColors.datePickerBorder, radius: 10, width: 3),
      ),
      items: _currencies.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Row(
              children: <Widget>[
                Text(_getCategoryText(category),
                    style:  AppTextStyle.getBaseStyle(color: AppColors.textGrey)),
              ],
            ));
      }).toList(),
    );
  }

  String _getCategoryText(String value) { // 下拉選單 多國
    switch(value) {
      case 'BUY':
        return tr('buyer');
      case 'SELL':
        return tr('seller');
      case 'PRICE':
        return tr('copyReservation');
      // case 'ITEM': // 隱藏不做
      //   return tr('singleAppointment');
      // case '': // test 前端有兩個 轉移NFT / 轉出NFT ????
      //   return tr('transferNFT');
      // case 'FEE': // 隱藏不做
      //   return tr('serviveFee');
      case 'ACTIVITY':
        return tr('activitiesUSDT');
      case 'DEPOSIT':
        return tr('walletRecharge');
      case 'WITHDRAW':
        return tr('walletWithdraw');
      case 'ROYALTY':
        return tr('royalty');
      case 'DEPOSIT_NFT':
        return tr('depositNFT');
      case 'TRANSFER_NFT':
        return tr('transferOut');
    }
    return '';
  }


}