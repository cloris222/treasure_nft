import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/count_down_timer.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../constant/theme/app_image_path.dart';
import '../../widgets/button/login_button_widget.dart';


class TradeMainView extends StatelessWidget {
  const TradeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [const DomainBar(), _countDownView(context)],
      ),
    );
  }

  Widget _countDownView(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          AppImagePath.countDownBackground,
          width: UIDefine.getWidth(),
          height: UIDefine.getWidth(),
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.only(top: UIDefine.getHeight() / 25),
          width: UIDefine.getWidth() / 1.1,
          height: UIDefine.getWidth() / 1.3,
          decoration: AppStyle().styleColorBorderBackground(
              color: Colors.white,
              backgroundColor: Colors.transparent,
              borderLine: 2),
        ),
        Container(
          margin: EdgeInsets.only(top: UIDefine.getHeight() / 25),
          width: UIDefine.getWidth() / 1.2,
          height: UIDefine.getWidth() / 1.45,
          decoration: AppStyle().styleColorsRadiusBackground(
              color: Colors.white.withOpacity(0.5)),
        ),
        Positioned(
          top: UIDefine.getHeight() / 8,
          child: Column(
            children: [
              Image.asset(
                AppImagePath.clockBlue,
                width: UIDefine.getWidth() / 3.6,
                height: UIDefine.getWidth() / 3.6,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: UIDefine.getHeight() / 40,
              ),
              CountDownTimer(),
              LoginButtonWidget(
                width: UIDefine.getWidth() / 1.7,
                height: UIDefine.getHeight() / 20,
                btnText: '(GMT + 8)00 : 23 : 00 PM',
                onPressed: () {},
              )
            ],
          ),
        ),
        _ruleAction(context)
      ],
    );
  }

  Widget _ruleAction(BuildContext context) {
    return Positioned(
        top: 10,
        right: 10,
        child: InkWell(
          onTap: (){
            SimpleCustomDialog(context).show();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: UIDefine.getWidth() / 6.5,
                  height: UIDefine.getHeight() / 25,
                  decoration: AppStyle().styleColorBorderBackground(
                    radius: 7,
                    color: Colors.black,
                    backgroundColor: Colors.transparent,
                    borderLine: 2,
                  )),
              Text(
                tr('trade-rules'),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: UIDefine.fontSize14),
              )
            ],
          ),
        ));
  }
}
