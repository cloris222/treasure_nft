import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../button/login_button_widget.dart';
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
            child: Container(
              width: UIDefine.getWidth() * 0.9,
              height: UIDefine.getWidth() * 0.9,
              color: Colors.white,
              child: Image.asset(
                AppImagePath.countDownBackground,
                width: UIDefine.getWidth(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.all(UIDefine.getPixelWidth(15)),
              decoration: AppStyle().styleColorBorderBackground(
                  color: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.5),
                  borderLine: 2),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.all(UIDefine.getPixelWidth(25)),
              decoration: AppStyle().styleColorsRadiusBackground(
                  color: Colors.white.withOpacity(0.78)),
            ),
          ),
          Positioned(
              top: UIDefine.getPixelWidth(10),
              right: UIDefine.getPixelWidth(10),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(AppImagePath.dialogCloseBtn))),
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
          Text(
            tr("reserve"),
            style: AppTextStyle.getBaseStyle(
                color: AppColors.textThreeBlack,
                fontWeight: FontWeight.w600,
                fontSize: UIDefine.fontSize16),
          ),
          SizedBox(
            height: UIDefine.getHeight() / 25,
          ),
          LevelDetailLabel(
            title: tr('reservationFee'),
            showCoins: false,
            content: widget.reservationFee,
            leftFontWeight: FontWeight.w400,
            rightFontWeight: FontWeight.w600,
          ),
          // LevelDetailLabel(
          //   title: tr('transactionHour'),
          //   showCoins: false,
          //   content: widget.transactionTime,
          //   leftFontWeight: FontWeight.w400,
          //   rightFontWeight: FontWeight.w600,
          // ),
          LevelDetailLabel(
            title: tr('transactionReward'),
            showCoins: false,
            content: '${widget.transactionReward}%',
            leftFontWeight: FontWeight.w400,
            rightFontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: UIDefine.getHeight() / 30,
          ),
          LoginButtonWidget(
              width: UIDefine.getWidth() / 3,
              height: UIDefine.getHeight() / 20,
              btnText: tr('check'),
              fontSize: UIDefine.fontSize14,
              fontWeight: FontWeight.w600,
              onPressed: widget.confirmBtnAction)
        ],
      ),
    );
  }
}
