import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';

import '../button/action_button_widget.dart';

class CustomAmountDialog extends BaseDialog {
  CustomAmountDialog(
    super.context, {
    super.backgroundColor = Colors.transparent,
    required this.isJumpKeyBoard,
    this.controller,
    this.onChanged,
    required this.confirmBtnAction,
  });

  ShowKeyBoard isJumpKeyBoard;
  TextEditingController? controller;
  VoidCallback confirmBtnAction;

  /// 當文字有改變觸發事件
  ValueChanged<String>? onChanged;

  @override
  Widget initContent(BuildContext context, StateSetter setState) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration:
              AppStyle().styleColorBorderBackground(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('custom'),
                style: TextStyle(fontSize: UIDefine.fontSize20),
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Image.asset(AppImagePath.tetherImg)),
                    ),
                  ),
                  Text(tr('under'))
                ],
              ),
              ActionButtonWidget(
                btnText: tr('check'),
                onPressed: confirmBtnAction,
                margin:
                    EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 20),
              ),
            ],
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ))
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
