import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

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
    this.bShowRed = false,
    this.inputFormatters = const [],
    this.showTitleText = true,
  }) : super(key: key);
  final String titleText;
  final String hintText;
  final TextEditingController controller;
  final bool isSecure;
  final ValidateResultData data;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final bool bShowRed;
  final List<TextInputFormatter> inputFormatters;
  final bool showTitleText;

  ///MARK: 帳號輸入資訊限制
  final bool bPasswordFormatter;

  ///MARK: 小數點限制兩位
  final bool bLimitDecimalLength;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Visibility(
        visible: showTitleText,
        child:_buildTextTitle(titleText)),
      LoginTextWidget(
        keyboardType: keyboardType,
        hintText: hintText,
        controller: controller,
        initColor: data.result ? AppColors.bolderGrey : AppColors.textRed,
        enabledColor: data.result ? AppColors.bolderGrey : AppColors.textRed,
        bFocusedGradientBolder: true,
        isSecure: isSecure,
        onChanged: onChanged,
        onTap: onTap,
        bPasswordFormatter: bPasswordFormatter,
        bLimitDecimalLength: bLimitDecimalLength,
        inputFormatters: inputFormatters,
      ),
      ErrorTextWidget(data: data, alignment: Alignment.centerRight)
    ]);
  }

  Widget _buildTextTitle(String text) {
    return SizedBox(
        // margin: const EdgeInsets.symmetric(vertical: 5), // (Ethan改) LoginTextWidget已有上下5 margin 間距過大
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                text,
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize14,
                    color: AppColors.textThreeBlack)),

            bShowRed ?
            Text(
                '*', style: AppTextStyle.getBaseStyle(
                color: AppColors.textRed, fontSize: UIDefine.fontSize20)
            ) :
              const SizedBox()
          ],
        )
    );
  }
}
