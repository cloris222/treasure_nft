import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../button/action_button_widget.dart';
import 'base_dialog.dart';

class SuccessDialog extends BaseDialog {
  SuccessDialog(super.context,
      {this.mainText,
      this.subText = '',
      this.okText = 'OK',
      this.mainTextSize = 27,
      this.mainMargin = const EdgeInsets.only(top: 10, bottom: 10),
      this.buttonMargin = const EdgeInsets.only(top: 10),
      this.isSuccess = true,
      super.isDialogCancel,
      required this.callOkFunction});

  String? mainText;
  String subText;
  String okText;
  double mainTextSize;
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
                  : AppImagePath.dialogClose),
          Container(
            margin: mainMargin,
            child: Text(mainText ?? '${tr('success')} !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: mainTextSize,
                    fontWeight: FontWeight.bold)),
          ),
          subText.isNotEmpty
              ? Text(subText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textGrey, fontSize: UIDefine.fontSize12))
              : const Text(''),
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
