import 'package:treasure_nft_project/utils/number_format_util.dart';

extension NumExtension on num {
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
}
