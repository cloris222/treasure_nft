import 'package:treasure_nft_project/utils/number_format_util.dart';

extension DoubleExtension on double {
  num checkNegativeNumber() {
    if (this < 0) {
      return 0;
    }
    return this;
  }

  String removeTwoPointFormat({bool needCheckNegative = false}) {
    return NumberFormatUtil()
        .removeTwoPointFormat(needCheckNegative ? checkNegativeNumber() : this);
  }

  String changeRebate() {
    return NumberFormatUtil().removeTwoPointFormat(this / 2.5 * 100);
  }
}
