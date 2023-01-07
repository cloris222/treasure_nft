import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/trade_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/trade/activity_viewmodel.dart';
import 'package:treasure_nft_project/views/trade/trade_draw_result_page.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../dialog/activity_rule_dialog.dart';
import '../dialog/animation_dialog.dart';
import '../dialog/new_reservation_dialog.dart';
import '../dialog/simple_custom_dialog.dart';
import '../dialog/success_dialog.dart';

class WorldCupView extends StatefulWidget {
  const WorldCupView({
    Key? key,
  }) : super(key: key);

  @override
  State<WorldCupView> createState() => _WorldCupViewState();
}

class _WorldCupViewState extends State<WorldCupView> {
  late ActivityViewModel viewModel;

  @override
  void initState() {
    viewModel = ActivityViewModel(
      setState: () {
        if (mounted) {
          setState(() {});
        }
      },
      reservationSuccess: () {
        viewModel.canReserve?.isUsed = true;
        AnimationDialog(context, AppAnimationPath.reserveSuccess).show();
        setState(() {});
      },
      bookPriceNotEnough: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0064'))
            .show();
      },
      notEnoughToPay: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0013'))
            .show();
      },
      depositNotEnough: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0041'))
            .show();
      },
      wrongTime: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0063'))
            .show();
      },
      errorMes: (errorCode) {
        SimpleCustomDialog(context, mainText: tr(errorCode), isSuccess: false)
            .show();
      },
      accountFrozen: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('EO_001_6'))
            .show();
      },
      activityNotFound: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('A_0032'))
            .show();
      },
      tradeForbidden: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0054'))
            .show();
      },
      levelNotEnough: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('EO_001_6'))
            .show();
      },
      activityReserveFull: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0075'))
            .show();
      },
      personalFull: () {
        SuccessDialog(context,
                callOkFunction: () {},
                isSuccess: false,
                mainText: tr("reserve-failed'"),
                subText: tr('APP_0076'))
            .show();
      },
    );
    viewModel.initState();
    super.initState();
  }

  String showButtonLabel() {
    if (viewModel.activityData.status == ActivityState.Activity) {
      return tr("start-booking-prize");
    } else if (viewModel.activityData.status == ActivityState.HideButton) {
      return '';
    } else {
      return tr("winnersList");
    }
  }

  @override
  Widget build(BuildContext context) {
    return viewModel.isOpen
        ? Column(
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
              SizedBox(
                height: UIDefine.fontSize10,
              ),
              _reservationView(context),
              SizedBox(
                height: UIDefine.fontSize16,
              ),
              Visibility(
                visible: viewModel.activityData.showButton,
                child: LoginButtonWidget(
                  btnText: showButtonLabel(),
                  onPressed: () {
                    if (viewModel.activityData.status ==
                        ActivityState.Activity) {
                      _createReservation(context);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TradeDrawResultPage()));
                    }
                  },
                  width: UIDefine.getWidth() * 0.7,
                ),
              ),
              SizedBox(
                height: UIDefine.fontSize16,
              ),
            ],
          )
        : const SizedBox();
  }

  Widget _infoView(BuildContext context) {
    TextStyle titleStyle = CustomTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize18,
        color: Colors.black,
        fontWeight: FontWeight.w500);
    TextStyle contentStyle = CustomTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize12,
        color: Colors.grey,
        fontWeight: FontWeight.w500);
    TextStyle blackContent = CustomTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize12,
        color: Colors.black,
        fontWeight: FontWeight.w500);
    return Container(
      margin: EdgeInsets.all(UIDefine.fontSize10),
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.bolderGrey, borderLine: 2),
      padding: EdgeInsets.all(UIDefine.fontSize10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  tr("activity-title-text"),
                  style: titleStyle,
                ),
              ),
              InkWell(
                onTap: () {
                  ActivityRuleDialog(context).show();
                },
                child: Image.asset(AppImagePath.questionBtn),
              )
            ],
          ),
          SizedBox(
            height: UIDefine.fontSize8,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Text(
                '${tr("activity-countdown")} : ${viewModel.getEndTimeLabel()}',
                textAlign: TextAlign.start,
                style: contentStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Wrap(
            children: [
              Text(
                '${tr("activity-time")} : ${BaseViewModel().changeTimeZone(viewModel.canReserve?.drawTime ?? '', isShowGmt: true)}',
                style: contentStyle,
              ),
            ],
          ),
          SizedBox(
            height: UIDefine.fontSize8,
          ),
          Wrap(
            children: [
              Text(
                '${tr("prizePool")} : ${BaseViewModel().numberCompatFormat((viewModel.canReserve?.memberPool ?? 0).toString())}'
                'USDT(+${tr("platformPrizePool")} ${BaseViewModel().numberCompatFormat((viewModel.canReserve?.platformPool ?? 0).toString())} USDT)',
                style: blackContent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reservationView(BuildContext context) {
    TextStyle blackContent = CustomTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize14,
        color: Colors.black,
        fontWeight: FontWeight.w500);
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
                    '${viewModel.canReserve?.deposit ?? ''}',
                    style: CustomTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize20,
                        fontWeight: FontWeight.w500),
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
              Wrap(children: [
                Text(
                  '(${viewModel.canReserve?.depositForConsume ?? 0}U${tr("limitedNFT")}+${viewModel.canReserve?.depositForPool ?? 0}U${tr("bonusPool")})',
                  style:  CustomTextStyle.getBaseStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ]),
              const SizedBox(
                height: 5,
              ),
              Text('${tr("prizePool-qualify")} :', style: blackContent),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LV${viewModel.canReserve?.levelMin ?? 1}~',
                    style: blackContent,
                  ),
                  Text(
                    'LV${viewModel.canReserve?.levelMax ?? 6}',
                    style: blackContent,
                  )
                ],
              )
            ],
          ),
        ),

        /// 預約活動成功後顯示動畫
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: (viewModel.canReserve?.isUsed ?? false) &&
                  (viewModel.canReserve?.isOpen ?? false),
              child: Image.asset(
                AppAnimationPath.activitySuccess,
                fit: BoxFit.cover,
              ),
            ))
      ],
    );
  }

  _createReservation(BuildContext context) async {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return NewReservationPopUpView(
            reservationFee: '${viewModel.checkDeposit?.deposit}',
            transactionTime: '${viewModel.checkDeposit?.tradingTime}',
            transactionReward: '${viewModel.checkDeposit?.reward}',

            /// 新增預約
            confirmBtnAction: () {
              viewModel.createReservation();
              setState(() {});
            },
          );
        },

        /// 透明頁一定要加
        opaque: false));
  }
}
