import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

class LevelUpOneDialog extends StatelessWidget {
  const LevelUpOneDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaseViewModel viewModel = BaseViewModel();
    return Scaffold(
      backgroundColor: AppColors.opacityBackground,
      body: GestureDetector(
        onTap: () {
          viewModel.popPage(context);
        },
        child: Container(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              margin:
                  EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(40)),
              child: Stack(
                children: [
                  SizedBox(
                    height: UIDefine.getPixelWidth(300),
                    width: UIDefine.getWidth(),
                  ),
                  Positioned(
                      top: UIDefine.getPixelWidth(50),
                      left: 0,
                      right: 0,
                      bottom: UIDefine.getPixelWidth(40),
                      child: Container(
                        decoration:
                            AppStyle().styleColorsRadiusBackground(radius: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: UIDefine.getPixelWidth(55)),
                            Text(
                              tr('lv_remind_title'),
                              style: AppTextStyle.getBaseStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: UIDefine.fontSize16,
                                  color: AppColors.textThreeBlack),
                            ),
                            Text(
                              tr('lv_remind_content'),
                              style: AppTextStyle.getBaseStyle(
                                  fontSize: UIDefine.fontSize14,
                                  color: AppColors.textThreeBlack),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LoginButtonWidget(
                                  isFillWidth: false,
                                  btnText: tr('gotoUse'),
                                  onPressed: () {
                                    viewModel. pushAndRemoveUntil(context,
                                        const MainPage(type: AppNavigationBarType.typeTrade));
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: UIDefine.getPixelWidth(5)),
                          ],
                        ),
                      )),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                          Center(child: Image.asset(AppImagePath.levelUpCoin)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
