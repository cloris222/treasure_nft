import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';

class WorldCupView extends StatefulWidget {
  const WorldCupView({Key? key}) : super(key: key);

  @override
  State<WorldCupView> createState() => _WorldCupViewState();
}

class _WorldCupViewState extends State<WorldCupView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(UIDefine.fontSize10),
      child: Column(
        children: [
          SizedBox(
              width: UIDefine.getWidth(),
              child: Image.asset(
                AppImagePath.worldCupTitleImg,
                fit: BoxFit.contain,
              )),
          _infoView(context)
        ],
      ),
    );
  }

  Widget _infoView(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: UIDefine.fontSize16,
        color: Colors.black,
        fontWeight: FontWeight.w500);
    TextStyle contentStyle =
        TextStyle(fontSize: UIDefine.fontSize12, color: Colors.grey);
    return Container(
      margin: EdgeInsets.all(UIDefine.fontSize10),
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.bolderGrey, borderLine: 2),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '幸運世界盃NFT預約獎池',
                style: titleStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
