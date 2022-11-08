import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../button/action_button_widget.dart';
import '../button/login_button_widget.dart';
import '../gradient_text.dart';
import '../label/level_detail.dart';

class NewReservationPopUpView extends StatefulWidget {
  const NewReservationPopUpView(
      {Key? key,
      this.backgroundColor = AppColors.opacityBackground,
      required this.confirmBtnAction,
        required this.reservationFee,
        required this.transactionTime,
        required this.transactionReward})
      : super(key: key);

  final Color backgroundColor;
  final VoidCallback confirmBtnAction;
  final String reservationFee;
  final String transactionTime;
  final String transactionReward;

  @override
  State<NewReservationPopUpView> createState() =>
      _NewReservationPopUpViewState();
}

class _NewReservationPopUpViewState extends State<NewReservationPopUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,

      ///MARK: 禁止返回前頁
      body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: _popupViewBackground(context)),
    );
  }

  Widget _popupViewBackground(BuildContext context) {
    double padding = MediaQuery.of(context).padding.top;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: padding, bottom: padding),
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              AppImagePath.countDownBackground,
              width: UIDefine.getWidth(),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: UIDefine.getWidth() / 1.1,
            height: UIDefine.getWidth() * 0.8,
            decoration: AppStyle().styleColorBorderBackground(
                color: Colors.white,
                backgroundColor: Colors.transparent,
                borderLine: 2),
          ),
          Container(
            width: UIDefine.getWidth() / 1.2,
            height: UIDefine.getWidth() * 0.72,
            decoration: AppStyle().styleColorsRadiusBackground(
                color: Colors.white.withOpacity(0.5)),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(AppImagePath.closeDialogBtn))),
          Positioned(left: 0, right: 0, child: (_reservationContent(context)))
        ],
      ),
    );
  }

  Widget _reservationContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientText(
            tr("reserve"),
            size: UIDefine.fontSize24,
            weight: FontWeight.w600,
          ),
          SizedBox(
            height: UIDefine.getHeight() / 25,
          ),
          LevelDetailLabel(
            title: tr('reservationFee'),
            showCoins: false,
            content: widget.reservationFee,
            rightFontWeight: FontWeight.bold,
          ),
          LevelDetailLabel(
            title: tr('transactionHour'),
            showCoins: false,
            content: widget.transactionTime,
            rightFontWeight: FontWeight.bold,
          ),
          LevelDetailLabel(
            title: tr('transactionReward'),
            showCoins: false,
            content: '${widget.transactionReward}%',
            rightFontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: UIDefine.getHeight() / 30,
          ),
          LoginButtonWidget(
            width: UIDefine.getWidth() / 3,
            height: UIDefine.getHeight() / 20,
            btnText: tr('check'),
            fontSize: UIDefine.fontSize14,
            fontWeight: FontWeight.bold,
            onPressed: widget.confirmBtnAction
          )
        ],
      ),
    );
  }
}
