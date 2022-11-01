import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/team/team_contribution_page.dart';
import 'package:treasure_nft_project/views/personal/team/team_member_page.dart';
import 'package:treasure_nft_project/views/personal/team/team_order_page.dart';
import 'package:treasure_nft_project/views/personal/team/team_referral_code_page.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/check_level_info.dart';
import '../../utils/number_format_util.dart';
import '../../widgets/label/personal_param_item.dart';

class PersonalSubTeamView extends StatelessWidget {
  const PersonalSubTeamView({Key? key, this.levelInfo}) : super(key: key);
  final CheckLevelInfo? levelInfo;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      children: [
        const SizedBox(width: 1),
        _buildTitle(),
        _buildCenter(),
        _buildButton(context),
        const SizedBox(width: 1),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Image.asset(
        AppImagePath.myTeamIcon,
        width: UIDefine.getScreenWidth(8),
        fit: BoxFit.fitWidth,
      ),
      const SizedBox(width: 5),
      Text(tr('myTeam'),
          style: TextStyle(
              fontSize: UIDefine.fontSize20,
              fontWeight: FontWeight.bold,
              color: AppColors.dialogBlack))
    ]);
  }

  Widget _buildCenter() {
    int validInvites = 0;
    if (levelInfo != null) {
      validInvites = levelInfo!.activeDirect + levelInfo!.activeIndirect;
    }
    return Row(
      children: [
        Flexible(
          child: PersonalParamItem(
              title: tr('teamRewards'),
              value:
                  NumberFormatUtil().removeTwoPointFormat(levelInfo?.income)),
        ),
        Flexible(
          child: PersonalParamItem(
              title: tr('validInvites'), value: '$validInvites'),
        ),
        Flexible(
            child: PersonalParamItem(
                title: tr('ALevel'), value: '${levelInfo?.activeDirect}')),
        Flexible(
          child: PersonalParamItem(
              title: tr('BCLevel'), value: '${levelInfo?.activeIndirect}'),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
        width: UIDefine.getWidth(),
        decoration: AppStyle().styleUserSetting(),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(children: [
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
        ]));
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
