//MARK: 檢查字串回傳的結果
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';

class ValidateResultData {
  final bool result;
  final String message;
  final Color textColor;

  ValidateResultData(
      {this.result = true,
      this.message = '',
      this.textColor = AppColors.textRed});

  String getMessage() {
    if (message.isEmpty) {
      return tr('rule_void');
    }
    return message;
  }
}
