import 'package:flutter/services.dart';

/// 限制數字輸入 總位數 和 小數點後幾位
class NumLengthInputFormatter extends TextInputFormatter {
  NumLengthInputFormatter({
    this.decimalLength = 2,
    this.integerLength = 99
  }) : super();

  int decimalLength; // 小數點後

  int integerLength; // 小數點前(整數幾位)

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (newValue.text.contains('.')) {
      int pointIndex = newValue.text.indexOf('.');
      String beforePoint = newValue.text.substring(0, pointIndex);

      if (beforePoint.length > integerLength) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;

      } else {
        String afterPoint = newValue.text.substring(pointIndex + 1, newValue.text.length);
        if (afterPoint.length > decimalLength) {
          value = oldValue.text;
          selectionIndex = oldValue.selection.end;
        }
      }

    } else {
      if (newValue.text.length > integerLength) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
