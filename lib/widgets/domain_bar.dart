import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

class DomainBar extends StatelessWidget {
  const DomainBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: UIDefine.getScreenHeight(7),
        width: UIDefine.getWidth(),
        decoration: AppStyle().baseGradient(),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                tr('officialSite_title'),
                style: TextStyle(
                    fontSize: UIDefine.fontSize12,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              )
            ])));
  }
}
