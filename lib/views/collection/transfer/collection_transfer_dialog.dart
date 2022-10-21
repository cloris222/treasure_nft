import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/timer_util.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../../../constant/theme/app_colors.dart';


class CollectionTransferDialog extends BaseDialog {
  CollectionTransferDialog(super.context, this.imgUrl, this.name) : super(isDialogCancel: false);

  String imgUrl;
  String name;
  String leftTime = '15 : 00';
  bool bEmpty = false;
  TextEditingController controller = TextEditingController();
  late StateSetter setState;

  @override
  Future<void> initValue() async {
    // TODO: implement initValue
  }

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    this.setState = setState;
    return SizedBox(
      width: UIDefine.getScreenWidth(97),
      height: UIDefine.getScreenWidth(119),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(imgUrl,
              width: UIDefine.getScreenWidth(42.2),
              height: UIDefine.getScreenWidth(42.2)),

          SizedBox(height: UIDefine.getScreenWidth(11.11)),

          Text(
            name,
            style: TextStyle(
                fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: UIDefine.getScreenWidth(11.11)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '信箱驗證碼',
                style: TextStyle(
                    fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
              ),

              /// 驗證碼輸入框
                  SizedBox(
                      width: UIDefine.getScreenWidth(27.77),
                      height: UIDefine.getScreenWidth(11.11),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.bolderGrey, width: 2),
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.bolderGrey, width: 2),
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.bolderGrey, width: 2),
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            filled: true,
                            fillColor: AppColors.textWhite,
                            contentPadding:
                            EdgeInsets.only(left: 10, bottom: 6, top: 6)
                        ),
                      )
                  ),

              /// Get按鈕
              Container(
                height: UIDefine.getScreenWidth(11.11),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainThemeButton, width: 2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                    onPressed: () {
                      _pressGet();
                    },
                    child: Text(
                      tr('get'), // 轉讓
                      style: TextStyle(
                          color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                    )
                ),
              )
            ],
          ),

          SizedBox(height: UIDefine.getScreenWidth(1)),

          Visibility(
            visible: bEmpty,
            child: Text(
              '驗證碼不得為空',
              style: TextStyle(color: AppColors.textRed,
                  fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w400),
            ),
          ),

          SizedBox(height: UIDefine.getScreenWidth(3.33)),

          Text(
            '有效時間：' + leftTime,
            style: TextStyle(color: AppColors.textRed,
                fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: UIDefine.getScreenWidth(8.33)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: UIDefine.getScreenWidth(32),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainThemeButton, width: 2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                    onPressed: () {
                      _pressCancel();
                    },
                    child: Text(
                      tr('Cancel'), // 轉讓
                      style: TextStyle(
                          color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                    )
                ),
              ),

              Container(
                width: UIDefine.getScreenWidth(32),
                decoration: BoxDecoration(
                    color: AppColors.mainThemeButton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                    onPressed: () {
                      _pressVerify();
                    },
                    child: Text(
                      tr('Verify'), // 販售
                      style: TextStyle(
                          color: AppColors.textWhite, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                    )
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
        '轉出確認',
        style:
        TextStyle(fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w500),
      )
    );
  }

  void _pressGet() {
    /// 倒計時
    CountDownTimerUtil().initMMSS(callBackListener:
    MyCallBackListener(
        myCallBack: (sTimeLeft) {
          setState(() { leftTime = sTimeLeft; });
        }),
        endTimeSeconds: 900
    );

    /// API

  }

  void _pressVerify() {
    if (controller.text == '') {
      setState(() { bEmpty = true; });
      return;
    }

    /// API
  }

  void _pressCancel() {
    closeDialog();
  }


}
