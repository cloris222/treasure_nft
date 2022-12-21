import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/login/register_main_page.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

class HomeSubSignupView extends StatelessWidget {
  const HomeSubSignupView({Key? key, required this.viewModel})
      : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: viewModel.getMainPadding(),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(tr('create-sell-title').toUpperCase(),
              style: viewModel.getMainTitleStyle()),
          SizedBox(height: UIDefine.getPixelHeight(20)),
          Text(tr('index_intro1'),
              style: viewModel.getContextStyle(color: AppColors.textGrey)),
          SizedBox(height: UIDefine.getPixelHeight(15)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            LoginButtonWidget(
                radius: 43,
                btnText: tr('signUp').toUpperCase(),
                isFillWidth: false,
                padding: EdgeInsets.symmetric(
                    horizontal: UIDefine.getPixelWidth(10)),
                onPressed: () {
                  if (!viewModel.isLogin()) {
                    viewModel.pushPage(context, const RegisterMainPage());
                  }
                })
          ]),
          SizedBox(height: UIDefine.getPixelHeight(15)),
          Image.asset(AppImagePath.loginPhoto,
              height: UIDefine.getPixelHeight(300), fit: BoxFit.fitHeight),
          SizedBox(height: UIDefine.getPixelHeight(15)),
        ]));
  }
}
