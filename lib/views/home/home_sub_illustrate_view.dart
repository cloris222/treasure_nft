import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';

class HomeSubIllustrateView extends StatelessWidget {
  const HomeSubIllustrateView({Key? key, required this.viewModel})
      : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().buildGradient(
          radius: 0, colors: AppColors.gradientBackgroundColorBg),
      padding: viewModel.getMainPadding(width: 30, height: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tr('index-illustrate-text-1'),
            textAlign: TextAlign.center,
            style: viewModel.getMainTitleStyle(),
          ),
          _buildSubView(
            Image.asset(AppImagePath.fastIcon, fit: BoxFit.contain),
            tr('index-illustrate-text-2'),
            tr('index-illustrate-text-4'),
          ),
          _buildSubView(
            Image.asset(AppImagePath.growthIcon, fit: BoxFit.contain),
            tr('index-illustrate-text-3'),
            tr('index-illustrate-text-5'),
          )
        ],
      ),
    );
  }

  _buildSubView(Widget icon, String title, String context) {
    return Container(
        padding: viewModel.getMainPadding(width: 5, height: 20),
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
                      style: viewModel.getSubTitleStyle(),
                    ),
                    SizedBox(height: UIDefine.getPixelHeight(5)),
                    Wrap(children: [
                      Text(
                        context,
                        style: viewModel.getContextStyle(),
                      ),
                    ])
                  ]))
            ]));
  }
}
