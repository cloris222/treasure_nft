import 'package:treasure_nft_project/constant/extension/num_extension.dart';

extension StringExtension on String {
  String removeTwoPointFormat({bool needCheckNegative = false}) {
    num result = 0;
    try {
      result = num.parse(this);
    } catch (e) {}

    return result.removeTwoPointFormat(needCheckNegative: needCheckNegative);
  }
}
