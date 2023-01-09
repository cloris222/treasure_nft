import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../constant/call_back_function.dart';
import '../../constant/ui_define.dart';
import '../button/action_button_widget.dart';
import 'base_dialog.dart';


class ConfirmDialog extends BaseDialog {
  ConfirmDialog(super.context,
      {this.mainText = '',
      this.mainMargin = const EdgeInsets.only(left: 10, ),
      this.buttonMargin = const EdgeInsets.only(top: 10),
      required this.callOkFunction});

  String mainText;
  EdgeInsetsGeometry mainMargin, buttonMargin;
  onClickFunction callOkFunction;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(alignment: Alignment.topRight,child: createGeneralTitle()),
      Container(
        margin: mainMargin,
          child: Text(mainText,textAlign: TextAlign.center,style: AppTextStyle.getBaseStyle(color: Colors.grey,fontSize: UIDefine.fontSize18),)),
      Container(
          margin: buttonMargin,
    child: ActionButtonWidget(isBorderStyle: true,btnText: tr('confirm'), onPressed: _onPress,isFillWidth: false,))
    ],);
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  Future<void> initValue() async {
  }
  void _onPress() {
    closeDialog();
    callOkFunction();
  }
}
