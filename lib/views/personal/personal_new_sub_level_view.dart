import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../models/http/parameter/user_property.dart';
import '../../utils/number_format_util.dart';
import '../../widgets/label/coin/tether_coin_widget.dart';

class PersonalNewSubLevelView extends StatelessWidget {
  const PersonalNewSubLevelView(
      {Key? key,
        this.userProperty,
        this.levelInfo,
        required this.onViewUpdate})
      : super(key: key);
  final UserProperty? userProperty;
  final CheckLevelInfo? levelInfo;
  final onClickFunction onViewUpdate;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.textWhite,
      child: Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(3.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('我的資產'), // test 缺多國 標題 我的資產
                style: TextStyle(color: AppColors.dialogBlack,
                    fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500)),
            _getLine(),

            _getContentWithCoin
              (tr('totalAssets'),
              userProperty?.totalBalance.toString(), UIDefine.fontSize20, isTotal: true),
            _getLine(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getContentWithCoin(tr("wallet-balance'"), userProperty?.balance.toString(), null),
                _getContentWithCoin(tr('nftAssets'), userProperty?.nftBalance.toString(), null),
                _getContentWithCoin(tr('totalIncome'), userProperty?.income.toString(), null)
              ],
            ),

            SizedBox(height: UIDefine.getScreenWidth(2.7)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getContentWithCoin(tr('bonus_referral'), userProperty?.savingBalance.toString(), null),
                _getContentWithCoin(tr('bonus_trade'), userProperty?.tradingSavingBalance.toString(), null),
                _getContentWithCoin(tr('fees'), '1%', null, showIcon: false, useFormat: false)
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget _getLine() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: UIDefine.getScreenWidth(2.7)),
      width: double.infinity,
      height: 1,
      color: AppColors.searchBar
    );
  }

  Widget _getContentWithCoin(String title, String? value, double? fontSize,
      {bool isTotal = false, bool showIcon = true, bool useFormat = true}) {
    return SizedBox(
      width: isTotal? UIDefine.getScreenWidth(70) : UIDefine.getScreenWidth(24.5),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, // 小標題
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.dialogGrey,
                  fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Row(
            children: [
              Visibility(
                  visible: showIcon,
                  child: TetherCoinWidget(
                    size: UIDefine.fontSize16,
                  )
              ),
              Text( useFormat ?
              ' ${NumberFormatUtil().removeTwoPointFormat(value)}'
                  : value??'', // 數值
                  style: TextStyle(
                      fontSize: fontSize?? UIDefine.fontSize16,
                      fontWeight: FontWeight.w500))
            ],
          )
        ],
      )
    );
  }

}