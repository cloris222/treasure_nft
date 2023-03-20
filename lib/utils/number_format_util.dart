import 'package:easy_localization/easy_localization.dart';

class NumberFormatUtil {
  String _setNumberFormat({required String format, dynamic value}) {
    return value != null ? NumberFormat(format).format(value) : '0';
  }

  ///MARK: 小數點兩位 無條件捨去
  String removeTwoPointFormat(dynamic value, {bool needSeparator = true}) {
    return _setNumberFormat(
        format: needSeparator ? '#,##0.##' : '##0.##',
        value: double.parse(removePointFormat(value, 2)));
  }

  ///MARK: 小數點兩位 無條件捨去
  String removeCustomPointFormat(dynamic value, int point) {
    String format = '#,##0.';
    if (point < 0) {
      point = 1;
    }
    for (int i = 0; i < point; i++) {
      format += '#';
    }
    return _setNumberFormat(
        format: format, value: double.parse(removePointFormat(value, point)));
  }

  ///取整數
  String integerFormat(dynamic value, {bool hasSeparator = true}) {
    return _setNumberFormat(
        format: hasSeparator ? '#,##0' : '##0', value: value);
  }

  ///取整數
  String integerTwoFormat(dynamic value) {
    if (value is String) {
      value = double.parse(value);
    }
    return _setNumberFormat(format: '00', value: value);
  }

  String removePointFormat(dynamic value, int point) {
    if (value == null) {
      return '0';
    }
    var num;
    if (value is double) {
      num = value;
    } else {
      if (value is String) {
        if (value.isEmpty) {
          value = '0.0';
        }
      }
      num = double.parse(value.toString());
    }
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) < point) {
      return (num.toStringAsFixed(point)
          .substring(0, num.toString().lastIndexOf(".") + point + 1)
          .toString());
    } else {
      return (num.toString()
          .substring(0, num.toString().lastIndexOf(".") + point + 1)
          .toString());
    }
  }

  /// 自動轉換數字為 K & M
  String numberCompatFormat(String value, {int decimalDigits = 2}) {
    if (value == '') {
      return '';
    }
    var formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      locale: 'en_US',
      symbol: '',
    ).format(double.parse(value));

    return formattedNumber;
  }
}
