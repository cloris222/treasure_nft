import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../dialog/activity_rule_dialog.dart';

class WorldCupView extends StatefulWidget {
  const WorldCupView(
      {Key? key,
      required this.countdownTime,
      required this.drawnTime,
      required this.poolSize,
      required this.buttonAction,
      required this.prizeReservation})
      : super(key: key);

  final String countdownTime;
  final String drawnTime;
  final String poolSize;
  final VoidCallback buttonAction;
  final String prizeReservation;

  @override
  State<WorldCupView> createState() => _WorldCupViewState();
}

class _WorldCupViewState extends State<WorldCupView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: UIDefine.getWidth(),
            child: Container(
              margin: EdgeInsets.all(UIDefine.fontSize14),
              child: Image.asset(
                AppImagePath.worldCupTitleImg,
                fit: BoxFit.contain,
              ),
            )),
        _infoView(context),
        SizedBox(height: UIDefine.fontSize10,),
        _reservationView(context),
        SizedBox(height: UIDefine.fontSize16,),
        LoginButtonWidget(
            btnText: tr("start-booking-prize"), onPressed: widget.buttonAction,width: UIDefine.getWidth()*0.7,),
        SizedBox(height: UIDefine.fontSize16,),
      ],
    );
  }

  Widget _infoView(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: UIDefine.fontSize18,
        color: Colors.black,
        fontWeight: FontWeight.w500);
    TextStyle contentStyle =
        TextStyle(fontSize: UIDefine.fontSize12, color: Colors.grey);
    TextStyle blackContent = TextStyle(
        fontSize: UIDefine.fontSize12,
        color: Colors.black,
        fontWeight: FontWeight.w500);
    return Container(
      margin: EdgeInsets.all(UIDefine.fontSize10),
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.bolderGrey, borderLine: 2),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("activity-title-text"),
                style: titleStyle,
              ),
              InkWell(
                onTap: () {ActivityRuleDialog(context).show();},
                child: Image.asset(AppImagePath.questionBtn),
              )
            ],
          ),
          SizedBox(
            height: UIDefine.fontSize8,
          ),
          Row(
            children: [
              Text(
                '${tr("activity-countdown")} : ',
                style: contentStyle,
              ),
              Text(
                widget.countdownTime,
                style: contentStyle,
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                '${tr("activity-time")} : ',
                style: contentStyle,
              ),
              Text(
                widget.drawnTime,
                style: contentStyle,
              )
            ],
          ),
          SizedBox(
            height: UIDefine.fontSize14,
          ),
          Row(
            children: [
              Text(
                '${tr("prizePool")} : ',
                style: blackContent,
              ),
              Text(
                widget.poolSize,
                style: blackContent,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _reservationView(BuildContext context) {
    TextStyle blackContent = TextStyle(
        fontSize: UIDefine.fontSize14,
        color: Colors.black,
        fontWeight: FontWeight.bold);
    return Stack(
      children: [
        SizedBox(
            width: UIDefine.getWidth(),
            child: Image.asset(
              AppImagePath.worldCupBackground,
              fit: BoxFit.fitWidth,
            )),
        Positioned(
          left: 0,
          right: 0,
          top: UIDefine.getHeight() / 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${tr("prizePool-reservation")} : ',
                style: blackContent,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.prizeReservation,
                    style: TextStyle(
                        fontSize: UIDefine.fontSize20,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    AppImagePath.tetherImg,
                    width: UIDefine.fontSize20,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),

              /// 更新多國
              Text(
                '(80U限量NFT+20U獎池金)',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('${tr("prizePool-qualify")} :', style: blackContent),
              const SizedBox(
                height: 5,
              ),
              Text(
                'LV1~LV6',
                style: blackContent,
              )
            ],
          ),
        )
      ],
    );
  }
}
