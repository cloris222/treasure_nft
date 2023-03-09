import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/views/personal/team/team_main_style.dart';

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        leftValue,
                        style: AppTextStyle.getBaseStyle(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: UIDefine.fontSize16,
                        ),
                      ),
                      SizedBox(height: UIDefine.getPixelWidth(7)),
                      Text(
                        leftTitle,
                        style: AppTextStyle.getBaseStyle(
                          color: AppColors.textSixBlack,
                          fontSize: UIDefine.fontSize12,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onPressActive(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        rightValue,
                        style: AppTextStyle.getBaseStyle(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: UIDefine.fontSize16,
                        ),
                      ),
                      SizedBox(height: UIDefine.getPixelWidth(7)),
                      Text(
                        rightTitle,
                        style: AppTextStyle.getBaseStyle(
                          color: AppColors.textSixBlack,
                          fontSize: UIDefine.fontSize12,
                        ),
                      ),
                    ]),
              ),
            ),
            TeamMainStyle().getPadding(1)
          ],
        ));
  }
}
