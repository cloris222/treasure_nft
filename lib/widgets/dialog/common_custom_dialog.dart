import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

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
    super.radius = 14,
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
  Widget initContent(BuildContext context, StateSetter setState,WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: UIDefine.getPixelWidth(70),
            height: UIDefine.getPixelWidth(70),
            child: _getImage()),
        Visibility(
            visible: title != '',
            child: Column(
              children: [
                SizedBox(height: UIDefine.getPixelWidth(20)),
                Text(title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textThreeBlack,
                        fontSize: UIDefine.fontSize16,
                        fontWeight: FontWeight.w600))
              ],
            )),
        Visibility(
            visible: content != '',
            child: Column(
              children: [
                SizedBox(height: UIDefine.getPixelWidth(12)),
                Text(content,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.getBaseStyle(
                        color: AppColors.textThreeBlack,
                        fontSize: UIDefine.fontSize14))
              ],
            )),
        SizedBox(height: UIDefine.getPixelWidth(24)),
        _getButton()
      ],
    );
  }

  Widget _getImage() {
    switch (type) {
      case DialogImageType.success:
        return Image.asset(AppImagePath.dialogSuccess, fit: BoxFit.contain);
      case DialogImageType.fail:
        return Image.asset(AppImagePath.dialogCancel, fit: BoxFit.contain);
      case DialogImageType.warning:
        return Image.asset(AppImagePath.dialogWarning, fit: BoxFit.contain);
    }
  }

  Widget _getButton() {
    if (bOneButton) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _solidButton(),
        ],
      );
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
    return LoginButtonWidget(
        btnText: rightBtnText,
        onPressed: () => onRightPress(),
        radius: 10,
        fontWeight: FontWeight.w600,
        fontSize: UIDefine.fontSize14,
        isFillWidth: false);
  }

  Widget _hollowButton() {
    /// 空心按鈕
    return LoginBolderButtonWidget(
      isFillWidth: false,
      btnText: leftBtnText,
      onPressed: () => onLeftPress(),
      radius: 10,
      fontWeight: FontWeight.w600,
      fontSize: UIDefine.fontSize14,
    );
  }
}
