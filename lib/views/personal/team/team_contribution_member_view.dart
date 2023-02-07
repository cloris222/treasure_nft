import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../constant/ui_define.dart';
import '../../../view_models/personal/team/team_contribution_viewmodel.dart';

class TeamContributionMemberView extends StatelessWidget {
  const TeamContributionMemberView(
      {Key? key, required this.viewModel, required this.type})
      : super(key: key);
  final TeamContributionViewModel viewModel;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
      child: Column(children: [
        _buildTitle(),
        SizedBox(height: UIDefine.getPixelWidth(15)),
        Expanded(child: viewModel.buildListView()),
      ]),
    );
  }

  Widget _buildTitle() {
    /// A級會員列表
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        flex: 2,
        child: Text(
          '$type${tr('levelMember')}',
          textAlign: TextAlign.start,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w400,
              color: AppColors.textThreeBlack),
        ),
      ),
      Expanded(
        flex: 1,
        child: Text(
          tr('bonus'),
          textAlign: TextAlign.start,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w400,
              color: AppColors.textThreeBlack),
        ),
      )
    ]);
  }
}
