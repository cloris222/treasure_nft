import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import 'button/action_button_widget.dart';
import 'dialog/base_dialog.dart';

class ImageDialog extends BaseDialog {
  ImageDialog(super.context,
      {this.mainText,
      this.subText = '',
      this.buttonText,
      this.mainTextSize,
      this.subTextSize,
      this.mainMargin = const EdgeInsets.only(top: 10, bottom: 10),
      this.buttonMargin = const EdgeInsets.only(top: 10),
      super.isDialogCancel,
      required this.assetImagePath,
      required this.callOkFunction});

  String? mainText;
  String subText;
  String? buttonText;
  double? mainTextSize;
  double? subTextSize;
  EdgeInsetsGeometry mainMargin, buttonMargin;
  onClickFunction callOkFunction;
  String assetImagePath;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          createImageWidget(asset: assetImagePath),
          Container(
            margin: mainMargin,
            child: Text(mainText ?? '${tr('success')} !',
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack,
                    fontSize: mainTextSize ?? UIDefine.fontSize24,
                    fontWeight: FontWeight.w500)),
          ),
          subText.isNotEmpty
              ? Text(subText,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.getBaseStyle(
                      color: AppColors.textGrey,
                      fontSize: subTextSize ?? UIDefine.fontSize14))
              : const Text(''),
          SizedBox(height: UIDefine.getScreenHeight(5)),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.zero,
            child: ActionButtonWidget(
                isFillWidth: false,
                btnText: buttonText ?? tr("check"),
                onPressed: _onPress,
                isBorderStyle: false),
          )
        ]);
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  Future<void> initValue() async {}

  void _onPress() {
    closeDialog();
    callOkFunction();
  }
}
