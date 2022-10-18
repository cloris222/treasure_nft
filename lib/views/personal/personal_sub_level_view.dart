import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../models/http/parameter/user_property.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/label/personal_param_item.dart';
import 'level/level_achievement_page.dart';

class PersonalSubLevelView extends StatelessWidget {
  const PersonalSubLevelView({Key? key, this.userProperty, this.levelInfo})
      : super(key: key);
  final UserProperty? userProperty;
  final CheckLevelInfo? levelInfo;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      children: [
        const SizedBox(width: 1),
        _buildCountry(),
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
          Text(
            '${tr('nationality')} : ',
            style: TextStyle(
                color: AppColors.dialogGrey,
                fontSize: UIDefine.fontSize16,
                fontWeight: FontWeight.w500),
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

  Widget _buildProperty() {
    return Container(
      width: UIDefine.getWidth(),
      decoration: AppStyle().styleUserSetting(),
      padding: const EdgeInsets.all(15),
      child: Wrap(runSpacing: 5, children: [
        _buildPropertyParam(
            title: tr('totalIncome'), value: userProperty?.income),
        _buildPropertyParam(
            title: tr("wallet-withdraw'"), value: userProperty?.savingBalance),
        _buildPropertyParam(
            title: tr("wallet-balance'"), value: userProperty?.balance),
        _buildPropertyParamRange(
            title: tr("reservation-product-amount'"),
            start: levelInfo?.buyRangeStart,
            end: levelInfo?.buyRangeEnd),
      ]),
    );
  }

  Widget _buildIcon() {
    return Image.asset(AppImagePath.tetherImg,
        width: UIDefine.fontSize20, height: UIDefine.fontSize14);
  }

  Widget _buildPropertyParam({required String title, double? value}) {
    return Row(children: [
      Flexible(
        child: SizedBox(
          width: UIDefine.getWidth(),
          child: Text(
            title,
            style: TextStyle(fontSize: UIDefine.fontSize14),
          ),
        ),
      ),
      Flexible(
        child: SizedBox(
          width: UIDefine.getWidth(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(),
              Text(
                  value == null
                      ? '0.0'
                      : NumberFormat('#,##0.##').format(value),
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
        child: SizedBox(
          width: UIDefine.getWidth(),
          child: Text(
            title,
            style: TextStyle(fontSize: UIDefine.fontSize14),
          ),
        ),
      ),
      Flexible(
        child: SizedBox(
          width: UIDefine.getWidth(),
          child: Row(
            children: [
              _buildIcon(),
              Text(
                  "${start == null ? "1" : NumberFormat('#,##0').format(start)}-${end == null ? "1" : NumberFormat('#,##0').format(end)}",
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
        Flexible(
          child: PersonalParamItem(
              title: tr('luckyValue'),
              value: '${levelInfo?.couponRate.toStringAsFixed(0)}'),
        ),
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

  void _showDailyPage(BuildContext context) {
    BaseViewModel().pushPage(context, const LevelAchievementPage());
  }
}
