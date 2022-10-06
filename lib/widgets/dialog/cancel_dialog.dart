import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/button/action_button_widget.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import 'base_dialog.dart';

class CancelDialog extends BaseDialog {
  CancelDialog(super.context,
      {this.titleText = '',
      this.titleTextSize = 20,
      this.titleMargin = const EdgeInsets.only(top: 0, bottom: 0),
      required this.cancel,
      required this.confirm,
      this.isShowImg = true,
      this.isShowMessage = false,
      this.subText = '',
      this.leftBtnTitle = 'Cancel',
      this.rightBtnTitle = 'Confirm',
      this.isShowDeleteBtn = false,
      required this.cancelAction});

  String titleText;
  double titleTextSize;
  EdgeInsetsGeometry titleMargin;
  VoidCallback cancel, confirm;
  bool isShowImg;
  bool isShowMessage;
  String subText;
  String leftBtnTitle;
  String rightBtnTitle;
  bool isShowDeleteBtn;
  VoidCallback cancelAction;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Visibility(
          visible: isShowImg,
          child: Image.asset(
            AppImagePath.dialogCancel,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox( // Ethan新增 20220902
          height: 30,
        ),
        Stack(
          // alignment: Alignment.bottomRight, // Ethan註解掉 20220902
          children: [
            Positioned(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: titleTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Visibility(
                visible: isShowDeleteBtn,
                child: IconButton(
                  icon: Image.asset(AppImagePath.dialogClose),
                  onPressed: cancelAction,
                )),
          ],
        ),
        Visibility(
            visible: isShowMessage,
            child: Text(
              subText,
              style:  TextStyle(fontSize: UIDefine.fontSize14, color: Colors.grey),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ActionButtonWidget(
                    margin: const EdgeInsets.only(top: 10),
                    btnText: leftBtnTitle,
                    onPressed: cancel,
                    isBorderStyle: true),
              ),
            ),
            Flexible(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ActionButtonWidget(
                    margin: const EdgeInsets.only(top: 10),
                    btnText: rightBtnTitle,
                    onPressed: confirm,
                    isBorderStyle: false),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget initTitle() {
    return Container();
  }

  @override
  void initValue() {
    // TODO: implement initValue
  }
}
