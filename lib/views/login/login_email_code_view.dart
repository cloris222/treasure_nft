import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import '../../constant/call_back_function.dart';
import '../../constant/theme/app_colors.dart';

import '../../models/data/validate_result_data.dart';
import '../../widgets/button/countdown_button_widget.dart';
import '../../widgets/label/error_text_widget.dart';
import '../../widgets/text_field/login_text_widget.dart';

class LoginEmailCodeView extends StatelessWidget {
  const LoginEmailCodeView(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.data,
      this.hintColor = AppColors.textHintGrey,
      this.isSecure = false,
      this.onChanged,
      this.onEditTap,
      required this.onPressSendCode,
      required this.onPressCheckVerify,
      this.onPressVerification,
      this.btnGetText,
      this.countdownSecond = 60})
      : super(key: key);
  final String hintText;
  final Color hintColor;
  final TextEditingController controller;
  final bool isSecure;
  final ValidateResultData data;
  final VoidCallback onPressSendCode;
  final VoidCallback onPressCheckVerify;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onEditTap;
  final PressVerification? onPressVerification;
  final int countdownSecond;

  ///MARK: 更換左邊的button 文字
  final String? btnGetText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: LoginTextWidget(
                keyboardType: TextInputType.number,
                hintText: hintText,
                hintColor: hintColor,
                controller: controller,
                initColor:
                    data.result ? AppColors.bolderGrey : AppColors.textRed,
                enabledColor:
                    data.result ? AppColors.bolderGrey : AppColors.textRed,
                onTap: onEditTap,
              ),
            ),
            CountdownButtonWidget(
              margin: EdgeInsets.only(left: UIDefine.getPixelWidth(5)),
              padding: EdgeInsets.symmetric(
                  vertical: UIDefine.getPixelWidth(10),
                  horizontal: UIDefine.getPixelWidth(15)),
              buttonType: 4,
              countdownSecond: countdownSecond,
              btnText: btnGetText ?? tr('get'),
              isFillWidth: false,
              setHeight: 50,
              onPress: onPressSendCode,
              onPressVerification: onPressVerification,
              fontSize: UIDefine.fontSize14,
            ),
            LoginButtonWidget(
                margin: EdgeInsets.only(left: UIDefine.getPixelWidth(5)),
                padding: EdgeInsets.symmetric(
                    vertical: UIDefine.getPixelWidth(10),
                    horizontal: UIDefine.getPixelWidth(10)),
                btnText: tr('verify'),
                isFillWidth: false,
                height: 50,
                fontSize: UIDefine.fontSize14,
                onPressed: onPressCheckVerify)
          ],
        ),
        ErrorTextWidget(data: data, alignment: Alignment.centerLeft),
      ],
    );
  }
}
