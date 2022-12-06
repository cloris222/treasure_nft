import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_list_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';

class TeamContributeItemView extends StatelessWidget {
  const TeamContributeItemView(
      {super.key, required this.itemData, required this.itemCount});

  final TeamContributeList itemData;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    TeamMemberViewModel viewModel = TeamMemberViewModel();
    return Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(3)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('$itemCount. ${itemData.name}',
              style: TextStyle(
                  fontSize: UIDefine.fontSize12,
                  color: AppColors.dialogGrey,
                  fontWeight: FontWeight.w500)),
          SizedBox(
              width: UIDefine.getScreenWidth(25),
              child: Row(children: [
                viewModel.getCoinImage(),
                viewModel.getPadding(1),
                Text(NumberFormatUtil().removeTwoPointFormat(itemData.share),
                    style: TextStyle(
                        fontSize: UIDefine.fontSize12,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start)
              ]))
        ]));
  }
}
