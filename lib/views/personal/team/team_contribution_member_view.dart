import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/personal/team/team_contribution_viewmodel.dart';
import '../../../view_models/personal/team/team_member_viewmodel.dart';

class TeamContributionMemberView extends StatelessWidget {
  const TeamContributionMemberView(
      {Key? key, required this.viewModel, required this.type})
      : super(key: key);
  final TeamContributionViewModel viewModel;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildTitle(),
      Flexible(child: viewModel.buildListView()),
    ]);
  }

  Widget _buildTitle() {
    TeamMemberViewModel memberViewModel = TeamMemberViewModel();

    /// A級會員列表
    return Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(3)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '$type${tr('levelMember')}',
            style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
          ),
          memberViewModel.getPadding(1),
          SizedBox(
              width: UIDefine.getScreenWidth(25),
              child: Text(
                tr('bonus'),
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize14),
              ))
        ]));
  }
}
