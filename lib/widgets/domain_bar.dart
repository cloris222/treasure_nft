import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class DomainBar extends StatelessWidget {
  const DomainBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: UIDefine.getScreenHeight(7),
        width: UIDefine.getWidth(),
        decoration: AppStyle().baseGradient(),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          tr('officialSite_title'),
          textAlign: TextAlign.left,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12,
              color: Colors.white,
              fontWeight: FontWeight.w300),
        ));
  }
}
