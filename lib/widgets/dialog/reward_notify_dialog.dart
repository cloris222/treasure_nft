import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/theme/app_colors.dart';

class RewardNotifyDialog extends StatelessWidget {
  const RewardNotifyDialog(
      {Key? key, required this.amount, required this.expireDays})
      : super(key: key);
  final num amount;
  final String expireDays;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BaseViewModel().popPage(context),
      child: Scaffold(
        backgroundColor: AppColors.opacityBackground,
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: UIDefine.getPixelWidth(40)),
                decoration: AppStyle().styleColorsRadiusBackground(radius: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTitle(context),
                    _buildContext(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: UIDefine.getPixelWidth(80),
          width: UIDefine.getPixelWidth(350),
          decoration: AppStyle().baseGradient(
              radius: 24, hasBottomLef: false, hasBottomRight: false),
        ),
        Positioned(
            top: UIDefine.getPixelWidth(30),
            bottom: UIDefine.getPixelWidth(15),
            right: 0,
            left: 0,
            child: Text(tr('reward-title'),
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: UIDefine.fontSize24))),
        Positioned(
          top: UIDefine.getPixelWidth(20),
          right: UIDefine.getPixelWidth(20),
          child: GestureDetector(
              onTap: () => BaseViewModel().popPage(context),
              child: Image.asset(AppImagePath.dialogCloseBtn,
                  color: Colors.white)),
        )
      ],
    );
  }

  Widget _buildContext(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: UIDefine.getPixelWidth(15)),
        Image.asset(AppImagePath.rewardIcon),
        SizedBox(height: UIDefine.getPixelWidth(20)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(50)),
          child: Text(
            format(tr('reward-detail'), {
              "usdt": NumberFormatUtil().removeTwoPointFormat(amount),
              "day": expireDays
            }),
            style: AppTextStyle.getBaseStyle(
                color: AppColors.dialogGrey,
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: UIDefine.getPixelWidth(30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginButtonWidget(
                isFillWidth: false,
                btnText: tr('mis_goto'),
                onPressed: () {
                  BaseViewModel().pushAndRemoveUntil(context,
                      const MainPage(type: AppNavigationBarType.typePersonal));
                }),
          ],
        ),
        SizedBox(height: UIDefine.getPixelWidth(20)),
      ],
    );
  }
}
