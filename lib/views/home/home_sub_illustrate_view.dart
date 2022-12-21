import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

class HomeSubIllustrateView extends StatelessWidget {
  const HomeSubIllustrateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().buildGradient(
          radius: 0, colors: AppColors.gradientBackgroundColorBg),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(30),
          vertical: UIDefine.getPixelHeight(30)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tr('index-illustrate-text-1'),
            style: TextStyle(
                color: AppColors.textBlack,
                fontSize: UIDefine.fontSize20,
                fontWeight: FontWeight.w500),
          ),
          _buildSubView(
            const Icon(Icons.add),
            tr('index-illustrate-text-2'),
            tr('index-illustrate-text-4'),
          ),
          _buildSubView(
            const Icon(Icons.add),
            tr('index-illustrate-text-3'),
            tr('index-illustrate-text-5'),
          )
        ],
      ),
    );
  }

  _buildSubView(Widget icon, String title, String context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: UIDefine.getPixelHeight(20),
            horizontal: UIDefine.getPixelWidth(5)),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              SizedBox(width: UIDefine.getPixelWidth(10)),
              Expanded(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: UIDefine.fontSize16),
                    ),
                    SizedBox(height: UIDefine.getPixelHeight(5)),
                    Wrap(children: [
                      Text(
                        context,
                        style: TextStyle(
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.w400,
                            fontSize: UIDefine.fontSize14),
                      ),
                    ])
                  ]))
            ]));
  }
}
