import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

class CheckWalletSettingDialog extends BaseDialog {
  CheckWalletSettingDialog(super.context,
      {required this.accountTRON,
      required this.accountBSC,
      required this.accountROLLOUT,
      required this.onConfirm});

  final String accountTRON;
  final String accountBSC;
  final String accountROLLOUT;
  final Color textColor = const Color(0xFF333333);
  final onClickFunction onConfirm;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    List<Widget> checkAddress = [];
    if (accountTRON.isNotEmpty) {
      checkAddress.add(_buildItem('TRC-20', accountTRON));
    }
    if (accountBSC.isNotEmpty) {
      checkAddress.add(_buildItem('BSC', accountBSC));
    }
    if (accountROLLOUT.isNotEmpty) {
      checkAddress.add(_buildItem('Polygon', accountROLLOUT));
    }

    return Wrap(
        runSpacing: UIDefine.getPixelWidth(10),
        alignment: WrapAlignment.center,
        children: [
          Text(tr('pleaseAddress'),
              style: CustomTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize16,
                  fontWeight: FontWeight.w500,
                  color: textColor)),
          Column(mainAxisSize: MainAxisSize.min, children: checkAddress),
          Text(tr('appSaveWalletHint'),
              style: CustomTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize14,
                  fontWeight: FontWeight.w400,
                  color: textColor)),
          _buildButton()
        ]);
  }

  @override
  Widget initTitle() {
    return const SizedBox();
  }

  @override
  Future<void> initValue() async {}

  Widget _buildItem(String type, String account) {
    return Container(
      width: UIDefine.getWidth(),
      decoration:
          AppStyle().styleColorBorderBackground(color: AppColors.bolderGrey),
      padding: EdgeInsets.symmetric(
          vertical: UIDefine.getPixelWidth(15),
          horizontal: UIDefine.getPixelWidth(10)),
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${tr('address')} ($type)',
              style: CustomTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize14,
                  fontWeight: FontWeight.w400,
                  color: textColor)),
          Text(account,
              style: CustomTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize14,
                  fontWeight: FontWeight.w500,
                  color: textColor))
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Row(
      children: [
        Expanded(
          child: LoginBolderButtonWidget(
              btnText: tr('cancel'),
              onPressed: () {
                BaseViewModel().popPage(context);
              }),
        ),
        Expanded(
          child: LoginButtonWidget(
              btnText: tr('confirm'),
              onPressed: () {
                BaseViewModel().popPage(context);
                onConfirm();
              }),
        ),
      ],
    );
  }
}
