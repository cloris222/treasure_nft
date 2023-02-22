import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/dialog/base_dialog.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

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
  Widget initContent(BuildContext context, StateSetter setState,WidgetRef ref) {
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
                style: AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: controller,
                        onChanged: onChanged,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: AppStyle().styleTextEditBorderBackground(color: Colors.grey),
                            filled: true,
                            fillColor: const Color(0XFFF4F7FA),
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white24),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: AppStyle().styleTextEditBorderBackground(color: Colors.blueAccent),
                            prefixIcon: Container(margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),child: Image.asset(AppImagePath.tetherImg,width: 10,height: 10,))),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text(tr('under'))
                  ],
                ),
              ),
              ActionButtonWidget(
                btnText: tr('check'),
                onPressed: confirmBtnAction,
                margin:
                    EdgeInsets.symmetric(horizontal: UIDefine.getWidth() / 6),
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
  Future<void> initValue() async {
    // TODO: implement initValue
  }
}
