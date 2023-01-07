import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../button/action_button_widget.dart';
import 'base_bottom_sheet.dart';

class SuccessBottomSheet extends BaseBottomSheet {
  SuccessBottomSheet(super.context,
      {this.mainText = 'Success！',
      this.subText = '',
      this.okText = 'OK',
      this.mainTextSize = 27,
      required this.callOkFunction,
      super.percentage = 0.4,
      super.needPercentage = false});

  String mainText;
  String subText;
  String okText;
  double mainTextSize;
  onClickFunction callOkFunction;

  @override
  Widget buildSheetWidget(BuildContext context, StateSetter setState) {
    double marginWidth = MediaQuery.of(context).size.width / 4.5;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          createTitle(Container(), needLine: false),
          Image.asset(AppImagePath.dialogSuccess,
              width: 100, height: 100, fit: BoxFit.contain),
          Container(
            margin: EdgeInsets.only(
                left: marginWidth, right: marginWidth, top: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(mainText,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textBlack,
                        fontSize: UIDefine.fontSize20,
                        fontWeight: FontWeight.w500)),
                subText.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(subText,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.getBaseStyle(
                                color: AppColors.textGrey, fontSize: UIDefine.fontSize12)),
                      )
                    : Container(margin: const EdgeInsets.only(top: 10)),
                ActionButtonWidget(margin: const EdgeInsets.only(top: 10),
                    btnText: tr('ok'), onPressed: _onPress, isBorderStyle: true)
              ],
            ),
          )
        ]);
  }

  @override
  void init() {}

  @override
  void dispose() {}

  void _onPress() {
    closeBottomSheet();
    callOkFunction();
  }
}
