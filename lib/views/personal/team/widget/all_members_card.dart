import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/personal/team/team_member_viewmodel.dart';

class AllMembersCard extends StatelessWidget {
  const AllMembersCard(
      {required this.leftTitle,
      required this.rightTitle,
      required this.leftValue,
      required this.rightValue,
      required this.onPressAll,
      required this.onPressActive,
      super.key});

  final String leftTitle;
  final String rightTitle;
  final String leftValue;
  final String rightValue;
  final onClickFunction onPressAll;
  final onClickFunction onPressActive;

  @override
  Widget build(BuildContext context) {
    TeamMemberViewModel viewModel = TeamMemberViewModel();
    return Container(
        alignment: Alignment.centerLeft,
        width: UIDefine.getWidth(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onPressAll(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leftTitle,
                        style: AppTextStyle.getBaseStyle(
                          color: AppColors.textGrey,
                          fontSize: UIDefine.fontSize12,
                        ),
                      ),
                      viewModel.getPadding(1),
                      Text(
                        leftValue,
                        style: AppTextStyle.getBaseStyle(
                          color: AppColors.mainThemeButton,
                          fontSize: UIDefine.fontSize14,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onPressActive(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rightTitle,
                        style: AppTextStyle.getBaseStyle(
                          color: AppColors.textGrey,
                          fontSize: UIDefine.fontSize12,
                        ),
                      ),
                      viewModel.getPadding(1),
                      Text(
                        rightValue,
                        style: AppTextStyle.getBaseStyle(
                          color: AppColors.mainThemeButton,
                          fontSize: UIDefine.fontSize14,
                        ),
                      ),
                    ]),
              ),
            ),
            viewModel.getPadding(1)
          ],
        ));
  }
}
