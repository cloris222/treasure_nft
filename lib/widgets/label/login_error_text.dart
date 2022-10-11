import 'package:flutter/material.dart';
import '../../models/data/validate_result_data.dart';

class LoginErrorText extends StatelessWidget {
  const LoginErrorText({Key? key, required this.data}) : super(key: key);
  final ValidateResultData data;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: !data.result,
        child: Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(data.getMessage(),
                style: TextStyle(color: data.textColor, fontSize: 12))));
  }
}
