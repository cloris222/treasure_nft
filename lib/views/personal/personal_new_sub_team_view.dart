import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/personal/team/team_contribution_page.dart';
import 'package:treasure_nft_project/views/personal/team/team_member_page.dart';
import 'package:treasure_nft_project/views/personal/team/team_order_page.dart';
import 'package:treasure_nft_project/views/personal/team/team_referral_code_page.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../utils/number_format_util.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/label/personal_param_item.dart';

class PersonalNewSubTeamView extends StatelessWidget {
  const PersonalNewSubTeamView({super.key, this.levelInfo});
  final CheckLevelInfo? levelInfo;

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
            Text(tr('myTeam'), // 標題 我的團隊
                style: AppTextStyle.getBaseStyle(color: AppColors.dialogBlack,
                    fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500)),

            _getLine(),

            Row(
              children: [
                Flexible(
                  child: PersonalParamItem(
                      title: tr('teamRewards'),
                      value:
                      NumberFormatUtil().removeTwoPointFormat(levelInfo?.income)),
                ),
                Flexible(
                  child: PersonalParamItem(
                      title: tr('validInvites'), value: _getValue().toString()),
                ),
                Flexible(
                    child: PersonalParamItem(
                        title: tr('ALevel'), value: '${levelInfo?.activeDirect}')),
                Flexible(
                  child: PersonalParamItem(
                      title: tr('BCLevel'), value: '${levelInfo?.activeIndirect}'),
                ),
              ],
            ),

            Row(children: [
              Flexible(
                  child: PersonalParamItem(
                      title: tr('teamMember'),
                      assetImagePath: AppImagePath.myTeamMemberIcon,
                      onPress: () => _showTeamMemberPage(context))),
              Flexible(
                  child: PersonalParamItem(
                      title: tr('teamContribution'),
                      assetImagePath: AppImagePath.myTeamContributionIcon,
                      onPress: () => _showTeamContributionPage(context))),
              Flexible(
                  child: PersonalParamItem(
                      title: tr('teamOrder'),
                      assetImagePath: AppImagePath.myTeamOrderIcon,
                      onPress: () => _showTeamOrderPage(context))),
              Flexible(
                  child: PersonalParamItem(
                      title: tr("referral-code'"),
                      assetImagePath: AppImagePath.myReferralCodeIcon,
                      onPress: () => _showReferralCodePage(context)))
            ])
          ],
        )
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

  int _getValue() {
    if (levelInfo != null) {
      int validInvites = levelInfo!.activeDirect + levelInfo!.activeIndirect;
      return validInvites;
    }
    return 0;
  }

  void _showTeamMemberPage(BuildContext context) {
    BaseViewModel().pushPage(context, const TeamMemberPage());
  }

  void _showTeamContributionPage(BuildContext context) {
    BaseViewModel().pushPage(context, const TeamContributionPage());
  }

  void _showTeamOrderPage(BuildContext context) {
    BaseViewModel().pushPage(context, const TeamOrderPage());
  }

  void _showReferralCodePage(BuildContext context) {
    BaseViewModel().pushPage(context, const TeamReferralCodePage());
  }

}