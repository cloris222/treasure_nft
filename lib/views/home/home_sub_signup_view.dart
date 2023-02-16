import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/login/register_main_page.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import 'home_main_style.dart';

class HomeSubSignupView extends StatelessWidget with HomeMainStyle {
  const HomeSubSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: getMainPadding(),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(30)),
            child: Text(tr('create-sell-title').toUpperCase(),
                textAlign: TextAlign.center, style: getMainTitleStyle()),
          ),
          SizedBox(height: UIDefine.getPixelHeight(20)),
          Text(tr('index_intro1'),
              style: getContextStyle(color: AppColors.textGrey)),
          SizedBox(height: UIDefine.getPixelHeight(15)),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            LoginButtonWidget(
                radius: 43,
                btnText: tr('signUp').toUpperCase(),
                fontFamily: AppTextFamily.Posterama1927,
                isFillWidth: false,
                padding: EdgeInsets.symmetric(
                    horizontal: UIDefine.getPixelWidth(10)),
                onPressed: () {
                  BaseViewModel viewModel = BaseViewModel();
                  if (!viewModel.isLogin()) {
                    viewModel.pushPage(context, const RegisterMainPage());
                  }
                })
          ]),
          SizedBox(height: UIDefine.getPixelHeight(15)),
          Image.asset(AppImagePath.invitePhoto,
              height: UIDefine.getPixelHeight(300), fit: BoxFit.contain),
          SizedBox(height: UIDefine.getPixelHeight(15)),
        ]));
  }
}
