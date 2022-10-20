import 'package:easy_localization/easy_localization.dart';

class NumberFormatUtil {
  String _setNumberFormat({required String format, dynamic value}) {
    return value != null ? NumberFormat(format).format(value) : '0';
  }

  ///MARK: 小數點兩位 無條件捨去
  String removeTwoPointFormat(dynamic value) {
    return _setNumberFormat(format: '#,##0.##', value: value);
  }

  ///取整數
  String integerFormat(dynamic value) {
    return _setNumberFormat(format: '#,##0', value: value);
  }
}
