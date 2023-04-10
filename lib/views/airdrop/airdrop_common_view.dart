import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';

class AirdropCommonView {
  Widget buildTitleView(String title) {
    return GradientThirdText(title,
        weight: FontWeight.w700, size: UIDefine.fontSize20);
  }

  Widget buildContextView(String context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(15)),
        child: Text(context,
            style: AppTextStyle.getBaseStyle(
                color: const Color(0xFF969696),
                fontWeight: FontWeight.w400,
                fontSize: UIDefine.fontSize12)));
  }

  Widget buildRewardInfo(String title, String context) {
    return Row(
      children: [
        Text(title,
            style: AppTextStyle.getBaseStyle(
                color: const Color(0xFF969696),
                fontWeight: FontWeight.w400,
                fontSize: UIDefine.fontSize14)),
        const Spacer(),
        Text(context,
            style: AppTextStyle.getBaseStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: UIDefine.fontSize14)),
      ],
    );
  }
}
