import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../models/data/validate_result_data.dart';
import '../../widgets/label/error_text_widget.dart';
import '../../widgets/text_field/login_text_widget.dart';

class LoginParamView extends StatelessWidget {
  const LoginParamView({
    Key? key,
    required this.titleText,
    required this.hintText,
    required this.controller,
    required this.data,
    this.isSecure = false,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.bPasswordFormatter = false,
    this.bLimitDecimalLength = false,
  }) : super(key: key);
  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final bool isSecure;
  final ValidateResultData data;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;

  ///MARK: 帳號輸入資訊限制
  final bool bPasswordFormatter;

  ///MARK: 小數點限制兩位
  final bool bLimitDecimalLength;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildTextTitle(titleText),
      LoginTextWidget(
        keyboardType: keyboardType,
        hintText: hintText,
        controller: controller,
        initColor: data.result ? AppColors.bolderGrey : AppColors.textRed,
        enabledColor: data.result ? AppColors.bolderGrey : AppColors.textRed,
        focusedColor: AppColors.mainThemeButton,
        isSecure: isSecure,
        onChanged: onChanged,
        onTap: onTap,
        bPasswordFormatter: bPasswordFormatter,
        bLimitDecimalLength: bLimitDecimalLength,
      ),
      ErrorTextWidget(data: data, alignment: Alignment.centerRight)
    ]);
  }

  Widget _buildTextTitle(String text) {
    return Container(
        // margin: const EdgeInsets.symmetric(vertical: 5), // (Ethan改) LoginTextWidget已有上下5 margin 間距過大
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: UIDefine.fontSize14)));
  }
}
