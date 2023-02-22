import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/views/home/home_main_style.dart';

class HomeSubIllustrateView extends StatelessWidget with HomeMainStyle {
  const HomeSubIllustrateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().buildGradient(
          radius: 0, colors: AppColors.gradientBackgroundColorBg),
      padding: getMainPadding(width: 30, height: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tr('index-illustrate-text-1'),
            textAlign: TextAlign.center,
            style: getMainTitleStyle(),
          ),
          _buildSubView(
            Image.asset(AppImagePath.fastIcon, fit: BoxFit.contain),
            tr('index-illustrate-text-2'),
            tr('index-illustrate-text-3'),
          ),
          _buildSubView(
            Image.asset(AppImagePath.growthIcon, fit: BoxFit.contain),
            tr('index-illustrate-text-4'),
            tr('index-illustrate-text-5'),
          )
        ],
      ),
    );
  }

  _buildSubView(Widget icon, String title, String context) {
    return Container(
        padding: getMainPadding(width: 5, height: 20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: UIDefine.getPixelWidth(40),
                  height: UIDefine.getPixelWidth(40),
                  child: icon),
              SizedBox(width: UIDefine.getPixelWidth(10)),
              Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      title,
                      style: getSubTitleStyle(),
                    ),
                    SizedBox(height: UIDefine.getPixelHeight(5)),
                    Wrap(children: [
                      Text(
                        context,
                        style: getContextStyle(),
                      ),
                    ])
                  ]))
            ]));
  }
}
