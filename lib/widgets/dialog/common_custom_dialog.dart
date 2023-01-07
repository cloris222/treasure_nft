import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';

enum DialogImageType { success, fail, warning }

/// 可選圖,單/雙按鈕,標題,內容 的共用Dialog
class CommonCustomDialog extends BaseDialog {
  CommonCustomDialog(
    super.context, {
    super.isDialogCancel,
    required this.type,
    this.title = '',
    this.content = '',
    this.bOneButton = true,
    this.leftBtnText = '',
    this.rightBtnText = '',
    required this.onLeftPress,
    required this.onRightPress,
  });

  DialogImageType type;
  String title;
  String content;
  bool bOneButton;
  String leftBtnText;
  String rightBtnText;
  Function onLeftPress;
  Function onRightPress;

  @override
  Widget initTitle() {
    return const SizedBox();
  }

  @override
  Future<void> initValue() async {}

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getImage(),
        Visibility(
            visible: title != '',
            child: Column(
              children: [
                SizedBox(height: UIDefine.getScreenWidth(2.7)),
                Text(title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textBlack,
                        fontSize: UIDefine.fontSize24,
                        fontWeight: FontWeight.w500))
              ],
            )),
        Visibility(
            visible: content != '',
            child: Column(
              children: [
                SizedBox(height: UIDefine.getScreenWidth(2.7)),
                Text(content,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.dialogGrey,
                        fontSize: UIDefine.fontSize14,
                        fontWeight: FontWeight.w500))
              ],
            )),
        SizedBox(height: UIDefine.getScreenWidth(8.5)),
        _getButton()
      ],
    );
  }

  Widget _getImage() {
    switch (type) {
      case DialogImageType.success:
        return Image.asset(AppImagePath.dialogSuccess);
      case DialogImageType.fail:
        return Image.asset(AppImagePath.dialogCancel);
      case DialogImageType.warning:
        return Image.asset(AppImagePath.dialogWarning);
    }
  }

  Widget _getButton() {
    if (bOneButton) {
      return _solidButton();
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _hollowButton()),
          SizedBox(width: UIDefine.getScreenWidth(2.7)),
          Expanded(child: _solidButton())
        ],
      );
    }
  }

  Widget _solidButton() {
    /// 實心按鈕
    return ActionButtonWidget(
        btnText: rightBtnText,
        onPressed: () => onRightPress(),
        radius: 10,
        fontWeight: FontWeight.w500,
        fontSize: UIDefine.fontSize16,
        isFillWidth: false);
  }

  Widget _hollowButton() {
    /// 空心按鈕
    return ActionButtonWidget(
      isFillWidth: false,
      isBorderStyle: true,
      btnText: leftBtnText,
      onPressed: () => onLeftPress(),
      radius: 10,
      fontWeight: FontWeight.w500,
      fontSize: UIDefine.fontSize16,
    );
  }
}
