import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';

class AllMembersCard extends StatelessWidget {
  const AllMembersCard({
    required this.leftTitle,
    required this.rightTitle,
    required this.leftValue,
    required this.rightValue,
    super.key
  });

  final String leftTitle;
  final String rightTitle;
  final String leftValue;
  final String rightValue;


  @override
  Widget build(BuildContext context) {
    TeamMemberViewModel viewModel = TeamMemberViewModel();
    return Container(
        alignment: Alignment.centerLeft,
        width: UIDefine.getWidth(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(leftTitle,
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: UIDefine.fontSize12,
                    ),
                  ),
                  viewModel.getPadding(1),

                  Text(leftValue,
                    style: TextStyle(
                      color: AppColors.mainThemeButton,
                      fontSize: UIDefine.fontSize14,
                    ),
                  ),

                ]),

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(rightTitle,
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: UIDefine.fontSize12,
                    ),
                  ),

                  viewModel.getPadding(1),

                  Text(rightValue,
                    style: TextStyle(
                      color: AppColors.mainThemeButton,
                      fontSize: UIDefine.fontSize14,
                    ),
                  ),

                ]),

            viewModel.getPadding(1)
          ],)
    );
  }


}