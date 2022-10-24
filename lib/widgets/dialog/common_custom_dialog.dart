import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../../constant/theme/app_colors.dart';

enum DialogImageType {
  success,
  fail,
  warning
}

/// 可選圖,單/雙按鈕,標題,內容 的共用Dialog
class CommonCustomDialog extends BaseDialog {
  CommonCustomDialog(super.context,
  {required this.type,
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
          visible: title!='',
          child: Column(
            children: [
              SizedBox(height: UIDefine.getScreenWidth(2.7)),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: UIDefine.fontSize24,
                      fontWeight: FontWeight.w500))
            ],
          )
        ),

        Visibility(
          visible: content!='',
          child: Column(
            children: [
              SizedBox(height: UIDefine.getScreenWidth(2.7)),
              Text(content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.dialogGrey,
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w500))
            ],
          )
        ),

        SizedBox(height: UIDefine.getScreenWidth(8.5)),

        _getButton()
      ],
    );
  }

  Widget _getImage() {
    switch(type) {
      case DialogImageType.success:
        return Image.asset(AppImagePath.dialogSuccess);
      case DialogImageType.fail:
        return Image.asset(AppImagePath.dialogClose);
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
          _hollowButton(),
          SizedBox(width: UIDefine.getScreenWidth(2.7)),
          _solidButton()
        ],
      );
    }
  }

  Widget _solidButton() { // 實心按鈕
    return Container(
      width: UIDefine.getScreenWidth(32),
      decoration: BoxDecoration(
          color: AppColors.mainThemeButton,
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextButton(
          onPressed: () {
            onRightPress();
          },
          child: Text(
            rightBtnText,
            style: TextStyle(
                color: AppColors.textWhite, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
          )
      ),
    );
  }

  Widget _hollowButton() { // 空心按鈕
    return Container(
      width: UIDefine.getScreenWidth(32),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.mainThemeButton, width: 2),
          borderRadius: BorderRadius.circular(10)
      ),
      child: TextButton(
          onPressed: () {
            onLeftPress();
          },
          child: Text(
            leftBtnText,
            style: TextStyle(
                color: AppColors.mainThemeButton, fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500),
          )
      ),
    );
  }

}