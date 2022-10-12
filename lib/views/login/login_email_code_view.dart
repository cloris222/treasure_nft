import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../models/data/validate_result_data.dart';
import '../../widgets/button/action_button_widget.dart';
import '../../widgets/button/countdown_button_widget.dart';
import '../../widgets/label/error_text_widget.dart';
import '../../widgets/text_field/login_text_widget.dart';

class LoginEmailCodeView extends StatelessWidget {
  const LoginEmailCodeView(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.data,
      this.isSecure = false,
      this.onChanged,
      required this.onPressSendCode,
      required this.onPressCheckVerify})
      : super(key: key);
  final String hintText;
  final TextEditingController controller;
  final bool isSecure;
  final ValidateResultData data;
  final VoidCallback onPressSendCode;
  final VoidCallback onPressCheckVerify;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child:
                  LoginTextWidget(hintText: hintText, controller: controller),
            ),
            CountdownButtonWidget(
              buttonType: 2,
              countdownSecond: 180,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              btnText: tr('get'),
              isFillWidth: false,
              setHeight: 50,
              onPress: onPressSendCode,
            ),
            ActionButtonWidget(
                btnText: tr('verify'),
                isFillWidth: false,
                setHeight: 50,
                onPressed: onPressCheckVerify)
          ],
        ),
        ErrorTextWidget(data: data, alignment: Alignment.centerLeft),
      ],
    );
  }
}
