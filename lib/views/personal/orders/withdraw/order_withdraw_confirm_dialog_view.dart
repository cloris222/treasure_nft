import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../../../../constant/ui_define.dart';

class OrderWithdrawConfirmDialogView extends BaseDialog {
  OrderWithdrawConfirmDialogView(super.context,
  {required this.chain,
  required this.address,
  required this.onLeftPress,
  required this.onRightPress});

  String chain;
  String address;
  Function onLeftPress;
  Function onRightPress;

  @override
  Widget initTitle() {
    return const SizedBox();
  }

  @override
  Future<void> initValue() async {
    // TODO: implement initValue
  }

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return SizedBox(
      width: UIDefine.getScreenWidth(97),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tr('pleaseAddress'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: UIDefine.fontSize24, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: UIDefine.getScreenWidth(8.27)),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(UIDefine.getScreenWidth(4)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: AppColors.bolderGrey, width: 1.5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('address') + ' (' + chain + ')',
                  style: TextStyle(
                      color: AppColors.mainThemeButton,
                      fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: UIDefine.getScreenWidth(4)),

                Text(
                  address,
                  style: TextStyle(fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          SizedBox(height: UIDefine.getScreenWidth(8.27)),

          Text(
            tr('checkAddressHint'),
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.dialogGrey,
                fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
          ),

          SizedBox(height: UIDefine.getScreenWidth(8.27)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _hollowButton(),
              SizedBox(width: UIDefine.getScreenWidth(2.7)),
              _solidButton()
            ],
          )
        ],
      ),
    );
  }

  Widget _solidButton() {
    // 實心按鈕
    return Container(
      width: UIDefine.getScreenWidth(30),
      decoration: BoxDecoration(
          color: AppColors.mainThemeButton,
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {
            onRightPress();
          },
          child: Text(
            tr('confirm'),
            style: TextStyle(
                color: AppColors.textWhite,
                fontSize: UIDefine.fontSize16,
                fontWeight: FontWeight.w500),
          )),
    );
  }

  Widget _hollowButton() {
    // 空心按鈕
    return Container(
      width: UIDefine.getScreenWidth(30),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.mainThemeButton, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: () {
            onLeftPress();
          },
          child: Text(
            tr('cancel'),
            style: TextStyle(
                color: AppColors.mainThemeButton,
                fontSize: UIDefine.fontSize16,
                fontWeight: FontWeight.w500),
          )),
    );
  }

}