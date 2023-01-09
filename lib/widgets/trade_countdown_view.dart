import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../constant/enum/trade_enum.dart';
import '../constant/global_data.dart';
import '../constant/theme/app_colors.dart';
import '../constant/theme/app_image_path.dart';
import '../constant/theme/app_style.dart';
import '../constant/ui_define.dart';
import '../models/data/trade_model_data.dart';
import '../utils/date_format_util.dart';
import '../utils/trade_timer_util.dart';
import 'button/login_button_widget.dart';
import 'count_down_timer.dart';
import 'dialog/trade_rule_dialot.dart';

class TradeCountDownView extends StatefulWidget {
  const TradeCountDownView({Key? key, required this.tradeData})
      : super(key: key);

  final TradeData tradeData;

  @override
  State<TradeCountDownView> createState() => _TradeCountDownViewState();
}

class _TradeCountDownViewState extends State<TradeCountDownView> {
  @override
  Widget build(BuildContext context) {
    TradeData tradeData = widget.tradeData;
    return Container(
      width: UIDefine.getWidth(),
      padding: EdgeInsets.only(
          top: UIDefine.getScreenWidth(5), bottom: UIDefine.getScreenWidth(8)),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(AppImagePath.countDownBackground),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.only(right: UIDefine.getScreenWidth(4.5)),
              alignment: Alignment.centerRight,
              child: _ruleAction(context)),
          SizedBox(height: UIDefine.getScreenWidth(5)),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // margin: EdgeInsets.only(top: UIDefine.getHeight() / 25),
                width: UIDefine.getWidth() / 1.1,
                height: UIDefine.getWidth() / 1.3,
                decoration: AppStyle().styleColorBorderBackground(
                    color: Colors.white,
                    backgroundColor: Colors.transparent,
                    borderLine: 2),
              ),
              Container(
                // margin: EdgeInsets.only(top: UIDefine.getHeight() / 25),
                width: UIDefine.getWidth() / 1.2,
                height: UIDefine.getWidth() / 1.45,
                decoration: AppStyle().styleColorsRadiusBackground(
                    color: Colors.white.withOpacity(0.5)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    tradeData.status == SellingState.NotYet
                        ? AppImagePath.clockBlue
                        : AppImagePath.clockRed,
                    width: UIDefine.getWidth() / 3.6,
                    height: UIDefine.getWidth() / 3.6,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: UIDefine.getHeight() / 50,
                  ),
                  tradeData.status == SellingState.Selling
                      ? Text(
                          tr('onSale'),
                          style: AppTextStyle.getBaseStyle(
                              color: AppColors.textRed,
                              fontSize: UIDefine.fontSize24,
                              fontWeight: FontWeight.w500),
                        )
                      : CountDownTimer(
                          duration: tradeData.duration,
                        ),
                  LoginButtonWidget(
                    width: UIDefine.getWidth() / 1.7,
                    height: UIDefine.getHeight() / 20,
                    btnText:
                        '(${GlobalData.userInfo.zone}) ${DateFormatUtil().getDateWith12HourInSecondFormat(TradeTimerUtil().getSellStartTime())}',
                    fontSize: UIDefine.fontSize14,
                    fontWeight: FontWeight.w500,
                    onPressed: () {},
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _ruleAction(BuildContext context) {
    return InkWell(
      onTap: () {
        TradeRuleDialog(context).show();
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: AppStyle().styleColorBorderBackground(
          radius: 7,
          color: Colors.black,
          backgroundColor: Colors.transparent,
          borderLine: 2,
        ),
        child: Text(
          tr('trade-rules'),
          style: AppTextStyle.getBaseStyle(
              fontWeight: FontWeight.w500, fontSize: UIDefine.fontSize14),
        ),
      ),
    );
  }
}
