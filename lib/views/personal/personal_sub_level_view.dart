import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../models/http/parameter/user_property.dart';
import '../../utils/number_format_util.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/label/personal_param_item.dart';
import 'level/level_achievement_page.dart';

///MARK: 總資產
class PersonalSubLevelView extends StatelessWidget {
  const PersonalSubLevelView(
      {Key? key, this.userProperty, this.levelInfo, required this.onViewUpdate})
      : super(key: key);
  final UserProperty? userProperty;
  final CheckLevelInfo? levelInfo;
  final onClickFunction onViewUpdate;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      children: [
        const SizedBox(width: 1),
        _buildTitle(),
        _buildProperty(),
        _buildReserve(context),
        const SizedBox(width: 1),
      ],
    );
  }

  Widget _buildCountry() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              '${tr('nationality')} : ',
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.dialogGrey,
                  fontSize: UIDefine.fontSize16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            '${tr(GlobalData.userInfo.country)} (${GlobalData.userInfo.zone})',
            style: TextStyle(
                color: AppColors.dialogBlack,
                fontSize: UIDefine.fontSize18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Image.asset(
        AppImagePath.walletRechargeIcon,
        width: UIDefine.getScreenWidth(8),
        fit: BoxFit.fitWidth,
      ),
      const SizedBox(width: 5),
      Text(tr('totalAssets'),
          style: TextStyle(
              fontSize: UIDefine.fontSize20,
              fontWeight: FontWeight.bold,
              color: AppColors.dialogBlack)),
      Flexible(child: Container()),
      Text(tr(' ${NumberFormatUtil().removeTwoPointFormat(userProperty?.totalBalance)}'),
          style: TextStyle(
              fontSize: UIDefine.fontSize20,
              fontWeight: FontWeight.bold,
              color: AppColors.dialogBlack))
    ]);
  }

  Widget _buildProperty() {
    Widget space = SizedBox(height: UIDefine.getScreenHeight(3));

    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleUserSetting(),
      padding: const EdgeInsets.all(15),
      child: Wrap(runSpacing: 5, children: [
        _buildPropertyParam(
            title: tr("wallet-balance'"), value: userProperty?.balance),
        space,
        _buildPropertyParam(
            title: tr('nftAssets'), value: userProperty?.nftBalance),
        space,
        _buildPropertyParam(
            title: tr('totalIncome'),
            value: userProperty?.income,
            needCoin: true),
        const Divider(color: AppColors.searchBar),
        _buildPropertyParam(
          title: tr("bonus_referral"),
          value: userProperty?.savingBalance,
        ),
        space,
        _buildPropertyParam(
            title: tr("bonus_trade"),
            value: userProperty?.tradingSavingBalance),
      ]),
    );
  }

  Widget _buildIcon() {
    return TetherCoinWidget(
      size: UIDefine.fontSize16,
    );
  }

  Widget _buildPropertyParam(
      {required String title, double? value, bool needCoin = false}) {
    return Row(children: [
      Flexible(
        flex: 2,
        child: SizedBox(
          width: UIDefine.getWidth(),
          child: Text(
            title,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: UIDefine.fontSize14,
                color: AppColors.dialogGrey,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      Flexible(
        flex: 1,
        child: SizedBox(
          width: UIDefine.getWidth(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              needCoin ? _buildIcon() : const SizedBox(),
              Text(' ${NumberFormatUtil().removeTwoPointFormat(value)}',
                  style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),
      )
    ]);
  }

  Widget _buildPropertyParamRange(
      {required String title, int? start, int? end}) {
    return Row(children: [
      Flexible(
        flex: 2,
        child: SizedBox(
          width: UIDefine.getWidth(),
          child: Text(
            title,
            maxLines: 1,
            style: TextStyle(fontSize: UIDefine.fontSize14),
          ),
        ),
      ),
      Flexible(
        flex: 1,
        child: SizedBox(
          width: UIDefine.getWidth(),
          child: Row(
            children: [
              _buildIcon(),
              Text(
                  " ${NumberFormatUtil().integerFormat(start)}-${NumberFormatUtil().integerFormat(end)}",
                  style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      )
    ]);
  }

  Widget _buildReserve(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: PersonalParamItem(
              title: tr('preOrderCoupon'),
              value: '${levelInfo?.dailyReverseAmount}'),
        ),

        ///MARK: 2022/10/21 不顯示幸運值
        // Flexible(
        //   child: PersonalParamItem(
        //       title: tr('luckyValue'),
        //       value: '${levelInfo?.couponRate.toStringAsFixed(0)}'),
        // ),
        Flexible(child: PersonalParamItem(title: tr('fees'), value: '1.5%')),
        Flexible(
          child: PersonalParamItem(
            title: tr('DailyMission'),
            assetImagePath: AppImagePath.dailyIcon,
            onPress: () => _showDailyPage(context),
          ),
        ),
      ],
    );
  }

  void _showDailyPage(BuildContext context) async {
    await BaseViewModel().pushPage(context, const LevelAchievementPage());
    onViewUpdate();
  }
}
