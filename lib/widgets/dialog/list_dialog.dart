import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
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
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          Text('$mainText',
              style: TextStyle(
                fontSize: UIDefine.fontSize24,
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
            child: ActionButtonWidget(
                margin: EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 5),
                btnText: tr("check"),
                onPressed: _onPress,
                isBorderStyle: false),
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