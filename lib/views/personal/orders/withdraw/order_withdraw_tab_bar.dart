import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import '../../../../constant/ui_define.dart';

class OrderWithdrawTabBar {
  Widget getCollectionTypeButtons(
      {required String currentExploreType,
      required List<String> dataList,
      required Function(String exploreType) changePage}) {
    List<Widget> buttons = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      bool isCurrent = (dataList[i] == currentExploreType);
      buttons.add(IntrinsicWidth(
        child: InkWell(
          onTap: () {
            changePage(dataList[i]);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: UIDefine.getPixelWidth(15),
                vertical: UIDefine.getPixelWidth(10)),
            decoration: isCurrent ? AppStyle().baseGradient(radius: 18) : null,
            child: Text(
              _getTabTitle(dataList[i]),
              maxLines: 1,
              style: AppTextStyle.getBaseStyle(
                  color: _getButtonColor(isCurrent),
                  fontSize: UIDefine.fontSize12,
                  fontWeight: _getTextWeight(isCurrent)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));
    }
    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(
          color: const Color(0xFFEEEEEE), radius: 18),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, children: buttons),
    );
  }

  String _getTabTitle(String value) {
    switch (value) {
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
    if (isCurrent) return Colors.white;
    return AppColors.textHintBlack;
  }

  FontWeight? _getTextWeight(bool isCurrent) {
    if (isCurrent) return FontWeight.w500;
    return null;
  }
}
