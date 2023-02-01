import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/timer_util.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/common_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/simple_custom_dialog.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../view_models/collection/collection_transfer_view_model.dart';
import '../../../widgets/button/countdown_button_widget.dart';
import '../../../widgets/button/login_bolder_button_widget.dart';
import '../../../widgets/button/login_button_widget.dart';

/// 收藏 > 未上架Item > 轉出
class CollectionTransferDialogView extends BaseDialog {
  CollectionTransferDialogView(super.context, this.imgUrl, this.name, this.itemId) : super(isDialogCancel: false);

  String imgUrl;
  String name;
  String itemId;
  String leftTime = '15 : 00';
  bool bEmpty = false;
  TextEditingController controller = TextEditingController();
  late StateSetter setState;
  CollectionTransferViewModel viewModel = CollectionTransferViewModel();

  @override
  Future<void> initValue() async {
    // TODO: implement initValue
  }

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    this.setState = setState;
    return SizedBox(
      width: UIDefine.getScreenWidth(97),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GraduallyNetworkImage(
            imageUrl: imgUrl,
            width: UIDefine.getScreenWidth(42.2),
            height: UIDefine.getScreenWidth(42.2),
          ),

          SizedBox(height: UIDefine.getScreenWidth(11.11)),

          Text(
            name,
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: UIDefine.getScreenWidth(8)),

          SizedBox(
              width: double.infinity,
              child: Text(
                tr("mail_valid_code"),
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
              )
          ),

          SizedBox(height: UIDefine.getScreenWidth(3)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 驗證碼輸入框
              SizedBox(
                width: UIDefine.getScreenWidth(45),
                height: UIDefine.getScreenWidth(11.11),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.bolderGrey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.bolderGrey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.bolderGrey, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    fillColor: AppColors.textWhite,
                    hintText: tr("code"),
                    hintStyle: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize10, color: AppColors.searchBar),
                    contentPadding: const EdgeInsets.only(left: 10, bottom: 6, top: 6)
                  ),
                )
              ),

              /// Get按鈕
              CountdownButtonWidget(
                buttonType: 4,
                countdownSecond: 60,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                btnText: tr('send'),
                isFillWidth: false,
                setHeight: UIDefine.getScreenWidth(11.11),
                onPress: _pressGet,
                // onPressVerification: onPressVerification,
              ),
            ],
          ),

          SizedBox(height: UIDefine.getScreenWidth(1)),

          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Visibility(
              visible: bEmpty,
              child: Text(
                tr("rule_void"),
                style: AppTextStyle.getBaseStyle(color: AppColors.reservationLevel5,
                    fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w400),
              ),
            ),
          ),

          SizedBox(height: UIDefine.getScreenWidth(3.33)),

          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              tr("valid_time") + ': ' + leftTime,
              style: AppTextStyle.getBaseStyle(color: AppColors.textRed,
                  fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
            ),
          ),

          SizedBox(height: UIDefine.getScreenWidth(8.33)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: UIDefine.getScreenWidth(32),
                child: LoginBolderButtonWidget(
                    onPressed: () {
                      _pressCancel();
                    },
                    btnText: tr('cancel'),
                ),
              ),

              SizedBox(
                width: UIDefine.getScreenWidth(32),
                child: LoginButtonWidget(
                    onPressed: () {
                      _pressVerify();
                    },
                    btnText: tr('verify'),
                ),
              )
            ],
          )
        ],
      )
    );
  }

  @override
  Widget initTitle() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        tr("transferCheck"),
        style:
        AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w500),
      )
    );
  }

  void _pressGet() {
    /// API
    Future<String> message = viewModel.getUserCodeResponse(
        'withdraw', GlobalData.userInfo.email, GlobalData.userInfo.country, 'MAIL');
    message.then((value) => { _startTimer(value) });
  }

  void _startTimer(String message) {
    if (message == 'SUCCESS') {
      /// 倒計時
      CountDownTimerUtil().initMMSS(callBackListener:
      MyCallBackListener(
          myCallBack: (sTimeLeft) {
            setState(() { leftTime = sTimeLeft; });
          }),
          endTimeSeconds: 900
      );

    } else {
      // test 如果失敗有要跳Alert?
    }
  }

  void _pressCancel() {
    closeDialog();
  }

  void _pressVerify() {
    /// 驗證碼空值檢查
    if (controller.text == '') {
      setState(() { bEmpty = true; });
      return;
    }

    /// API
    Future<String> result = viewModel.getCheckUserCodeResponse(
        'withdraw', 'MAIL', GlobalData.userInfo.email, GlobalData.userInfo.country,
        GlobalData.userInfo.phone, controller.text, _onErrorResult);
    result.then((message) => _onSuccessResult(message));
  }

  void _onSuccessResult(String message) {
    if (message == 'SUCCESS') {
      _showConfirmDialog();
    }
  }

  void _onErrorResult(String code) {
    _showErrorCodeDialog();
  }

  void _showErrorCodeDialog() {
     SimpleCustomDialog(context, mainText: tr("EO_005_2"), isSuccess: false).show();
  }

  void _showConfirmDialog() {
    CommonCustomDialog(context,
        type: DialogImageType.warning,
        title: tr("attention"),
        content: tr("tranfor_hint"),
        bOneButton: false,
        leftBtnText: tr('cancel'),
        rightBtnText: tr('confirm'),
        onLeftPress: (){
          Navigator.pop(context);
        },
        onRightPress: (){
          Future<String> result = viewModel.getTransferOutResponse(itemId, controller.text, _checkResponseCode);
          result.then((message) => _onTransferSuccess(message));
        })
        .show();
  }

  void _onTransferSuccess(String message) {
    if (message == 'SUCCESS') {
      SimpleCustomDialog(context, mainText: tr("success"), isSuccess: true).show();
    }
  }

  void _checkResponseCode(String code) {
    String msg = '';
    switch(code) {
      case 'APP_0049':
        msg = tr("APP_0049");
        break;
      case 'APP_0050':
        msg = tr("APP_0050");
        break;
    }
    SimpleCustomDialog(context, mainText: msg, isSuccess: false).show();
  }
}
