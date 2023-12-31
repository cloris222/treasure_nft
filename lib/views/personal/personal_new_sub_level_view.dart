import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/flex_two_text_widget.dart';

import '../../constant/call_back_function.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../models/http/parameter/user_property.dart';
import '../../utils/number_format_util.dart';
import '../../widgets/label/coin/tether_coin_widget.dart';
import 'level/level_bonus_record_page.dart';

class PersonalNewSubLevelView extends StatelessWidget {
  const PersonalNewSubLevelView(
      {Key? key, this.userProperty, this.levelInfo, required this.onViewUpdate})
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
              Text(tr('myAssets'),
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textBlack,
                      fontSize: UIDefine.fontSize16,
                      fontWeight: FontWeight.w600)),
              _getLine(),
              //總資產
              // _getContentWithCoin(tr('totalAssets'),
              //     userProperty?.getTotalBalance().toString(), UIDefine.fontSize14,
              //     isTotal: true),
              ///錢包餘額
              _getContentWithCoin(tr("wallet-balance'"),
                  userProperty?.getBalance().toString(), null),

              _getLine(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded( ///每日收益
                    child: _getContentWithCoin(tr("daily-profit"),
                        userProperty?.getTodayIncome().toString(), null),
                  ),
                  // Expanded(
                  //   child: _getContentWithCoin(tr('nftAssets'),
                  //       userProperty?.getNftBalance().toString(), null),
                  // ),
                  Expanded( ///綜合收入
                    child: _getContentWithCoin(tr('totalIncome'),
                        userProperty?.getIncome().toString(), null),
                  ),
                ],
              ),
              SizedBox(height: UIDefine.getScreenWidth(2.7)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _getContentWithCoin(
                      tr('bonus_referral'),
                      userProperty?.getSavingBalance().toString(),
                      null,
                      onTextPress: () {
                        ///推廣儲金罐
                        BaseViewModel().pushPage(
                            context,
                            const LevelBonusRecordPage(
                                isInitReferralBonus: true));
                      },
                    ),
                  ),

                  Expanded(
                    child: _getContentWithCoin(
                      tr('bonus_trade'),
                      userProperty?.getTradingSavingBalance().toString(),
                      null,
                      onTextPress: () {
                        ///交易儲金罐
                        BaseViewModel().pushPage(
                            context,
                            const LevelBonusRecordPage(
                                isInitReferralBonus: false));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: UIDefine.getScreenWidth(2.7)),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       child: _getContentWithCoin(
              //         tr('bonus_trade'),
              //         userProperty?.getTradingSavingBalance().toString(),
              //         null,
              //         onTextPress: () {
              //           ///交易儲金罐
              //           BaseViewModel().pushPage(
              //               context,
              //               const LevelBonusRecordPage(
              //                   isInitReferralBonus: false));
              //         },
              //       ),
              //     ),
              //     Expanded(
              //       child: _getContentWithCoin(tr('fees'), '1%', null,
              //           showIcon: false, useFormat: false),
              //     )
              //   ],
              // ),
            ],
          ),
        ));
  }

  Widget _getLine() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getScreenWidth(2.7)),
        width: double.infinity,
        height: 1,
        color: AppColors.personalBar);
  }

  Widget _getContentWithCoin(
    String title,
    String? value,
    double? fontSize, {
    bool isTotal = false,
    bool showIcon = true,
    bool useFormat = true,
    onClickFunction? onTextPress,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTextPress != null) {
          onTextPress();
        }
      },
      child: SizedBox(
          width: UIDefine.getWidth(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlexTwoTextWidget(
                alignment: Alignment.centerLeft,
                text: title, // 小標題
                color: AppColors.textThreeBlack,
                fontSize: 12,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Visibility(
                      visible: showIcon,
                      child: TetherCoinWidget(
                        size: UIDefine.fontSize16,
                      )),
                  Text(
                      useFormat
                          ? ' ${NumberFormatUtil().removeTwoPointFormat(value)}'
                          : value ?? '', // 數值
                      maxLines: 1,
                      style: AppTextStyle.getBaseStyle(
                          color: onTextPress != null
                              ? AppColors.mainThemeButton
                              : AppColors.textBlack,
                          fontSize: fontSize ?? UIDefine.fontSize16,
                          fontWeight: FontWeight.w600))
                ],
              )
            ],
          )),
    );
  }
}
