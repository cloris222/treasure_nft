import 'package:easy_localization/easy_localization.dart';

class NumberFormatUtil {
  String _setNumberFormat({required String format, dynamic value}) {
    return value != null ? NumberFormat(format).format(value) : '0';
  }

  ///MARK: 小數點兩位 無條件捨去
  String removeTwoPointFormat(dynamic value) {
    return removePointFormat(value, 2);
  }

  ///取整數
  String integerFormat(dynamic value, {bool hasSeparator = true}) {
    return _setNumberFormat(
        format: hasSeparator ? '#,##0' : '##0', value: value);
  }

  ///取整數
  String integerTwoFormat(dynamic value) {
    return _setNumberFormat(format: '00', value: value);
  }

  String removePointFormat(dynamic value, int point) {
    var num;
    if (value is double) {
      num = value;
    } else {
      num = double.parse(value.toString());
    }
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        point) {
      return (num.toStringAsFixed(point)
          .substring(0, num.toString().lastIndexOf(".") + point + 1)
          .toString());
    } else {
      return (num.toString()
          .substring(0, num.toString().lastIndexOf(".") + point + 1)
          .toString());
    }
  }
}
