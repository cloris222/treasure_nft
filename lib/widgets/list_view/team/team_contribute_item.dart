import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/team_contribute_list_data.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class TeamContributeItemView extends StatelessWidget {
  const TeamContributeItemView(
      {super.key, required this.itemData, required this.itemCount});

  final TeamContributeList itemData;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    TeamMemberViewModel viewModel = TeamMemberViewModel();
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(12)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 2,
            child: Text('$itemCount. ${itemData.name}',
                textAlign: TextAlign.start,
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize14,
                    color: AppColors.textThreeBlack,
                    fontWeight: FontWeight.w400)),
          ),
          Expanded(
            flex: 1,
            child: Row(children: [
              viewModel.getCoinImage(),
              viewModel.getPadding(1),
              Text(NumberFormatUtil().removeTwoPointFormat(itemData.share),
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start)
            ]),
          )
        ]));
  }
}
