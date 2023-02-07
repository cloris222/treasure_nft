import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import 'base_dialog.dart';

class SuccessDialog extends BaseDialog {
  SuccessDialog(super.context,
      {this.mainText,
      this.subText = '',
      this.okText = 'OK',
      this.mainTextSize,
      this.mainMargin = const EdgeInsets.only(top: 10, bottom: 10),
      this.buttonMargin = const EdgeInsets.only(top: 10),
      this.isSuccess = true,
      super.isDialogCancel,
      required this.callOkFunction,
      super.radius = 12});

  String? mainText;
  String subText;
  String okText;
  double? mainTextSize;
  bool isSuccess;
  EdgeInsetsGeometry mainMargin, buttonMargin;
  onClickFunction callOkFunction;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          createImageWidget(
              asset: isSuccess
                  ? AppImagePath.dialogSuccess
                  : AppImagePath.dialogCancel),
          Container(
            margin: mainMargin,
            child: Text(mainText ?? '${tr('success')} !',
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    color: AppColors.textBlack,
                    fontSize: mainTextSize ?? UIDefine.fontSize16,
                    fontWeight: FontWeight.w600)),
          ),
          subText.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(subText,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.getBaseStyle(
                          color: AppColors.textThreeBlack,
                          fontSize: UIDefine.fontSize14)),
                )
              : const Text(''),
          Container(
            margin: buttonMargin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginButtonWidget(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIDefine.getPixelWidth(15),
                      vertical: UIDefine.getPixelWidth(5)),
                  isFillWidth: false,
                  btnText: tr("check"),
                  onPressed: _onPress,
                ),
              ],
            ),
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
