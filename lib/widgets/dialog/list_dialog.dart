import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'base_dialog.dart';


class ListDialog extends BaseDialog {
  ListDialog(super.context,
      {this.mainText,
        this.mainMargin = const EdgeInsets.only(top: 10, bottom: 10),
        this.buttonMargin = const EdgeInsets.only(top: 10),
        required this.callOkFunction,
        required this.listView
      });

  String? mainText;
  EdgeInsetsGeometry mainMargin, buttonMargin;
  onClickFunction callOkFunction;
  Widget listView;

  @override
  Widget initContent(BuildContext context, StateSetter setState,WidgetRef ref) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          Text('$mainText',
              style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize24,
                fontWeight: FontWeight.w500
              )
          ),

          Padding(padding: EdgeInsets.all(UIDefine.getScreenHeight(1))),

          SizedBox(
            height: UIDefine.getScreenHeight(50),
            width: UIDefine.getScreenWidth(85),
            child: SingleChildScrollView(
              child:listView
            ),
          ),

          Container(
            margin: EdgeInsets.zero,
            child: LoginButtonWidget(
              height: UIDefine.getScreenHeight(7),
                margin: EdgeInsets.only(
                    left: UIDefine.getScreenWidth(20),
                    right: UIDefine.getScreenWidth(20),
                    top: UIDefine.getScreenWidth(6),
                ),
                btnText: tr("confirm"),
                onPressed: _onPress),
          )
        ]);
  }


  @override
  Future<void> initValue() async {}

  @override
  EdgeInsets defaultInsetPadding() {
    /// default is horizontal: 40.0, vertical: 24.0
    return const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0);
  }

  void _onPress() {
    closeDialog();
    callOkFunction();
  }

  @override
  Widget initTitle() {
    return Container();
  }
}
