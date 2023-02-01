import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

class ListBottomSheet extends BaseBottomSheet {
  ListBottomSheet(super.context,
      {super.percentage = 0.9,
      super.needPercentage = true,
      this.mainText,
      required this.callOkFunction,
      required this.listView,
      super.backgroundColor = Colors.white});

  String? mainText;
  onClickFunction callOkFunction;
  Widget listView;

  @override
  Widget buildSheetWidget(BuildContext context, StateSetter setState) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: EdgeInsets.only(
                  top: UIDefine.getPixelWidth(15),
                  left: UIDefine.getPixelWidth(20),
                  right: UIDefine.getPixelWidth(20)),
              child: TitleAppBar(title: '$mainText', needArrowIcon: false)),
          Padding(padding: EdgeInsets.all(UIDefine.getScreenHeight(1))),
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(
                  left: UIDefine.getPixelWidth(20),
                  right: UIDefine.getPixelWidth(20)),
              child: listView,
            )),
          ),
          Container(
            margin: EdgeInsets.zero,
            child: LoginButtonWidget(
                height: UIDefine.getPixelWidth(45),
                margin: EdgeInsets.only(
                  left: UIDefine.getPixelWidth(20),
                  right: UIDefine.getPixelWidth(20),
                  top: UIDefine.getPixelWidth(30),
                  bottom: UIDefine.getPixelWidth(30),
                ),
                radius: 22,
                btnText: tr("confirm"),
                onPressed: _onPress),
          )
        ]);
  }

  @override
  void dispose() {
  }

  @override
  void init() {
  }

  void _onPress() {
    closeBottomSheet();
    callOkFunction();
  }
}
