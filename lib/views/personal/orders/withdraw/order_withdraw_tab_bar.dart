import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../constant/ui_define.dart';

class OrderWithdrawTabBar {

  Widget getCollectionTypeButtons(
      {required String currentExploreType,
        required List<String> dataList,
        required Function(String exploreType) changePage}) {
    List<Widget> buttons = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      bool isCurrent = (dataList[i] == currentExploreType);
      buttons.add(
          IntrinsicWidth(
            child: Column(
              children: [
                SizedBox(
                  height: UIDefine.getScreenWidth(12),
                  child: TextButton(
                    onPressed: () {
                      changePage(dataList[i]);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(4.5), 0, UIDefine.getScreenWidth(3), 0),
                      child: Text(
                        _getTabTitle(dataList[i]),
                        style: TextStyle(color: _getButtonColor(isCurrent), fontSize: UIDefine.fontSize16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _getLineHeight(isCurrent),
                  color: _getLineColor(isCurrent),
                ),
              ],
            ),
          )
      );
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buttons
    );
  }

  String _getTabTitle(String value) {
    switch(value) {
      case 'Chain':
        return tr('chainTransfer');
      case 'Internal':
        return tr('innerTransfer');
    }
    return '';
  }

  double _getLineHeight(bool isCurrent) {
    if (isCurrent) return 2.5;
    return 1;
  }

  Color _getLineColor(bool isCurrent) {
    if (isCurrent) return Colors.blue;
    return Colors.grey;
  }

  Color _getButtonColor(bool isCurrent) {
    if (isCurrent) return Colors.black;
    return Colors.grey;
  }

}