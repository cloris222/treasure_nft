import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/data/validate_result_data.dart';

final globalTextProviderProvider =
    StateProvider.family.autoDispose<String, String>((ref, tag) {
  return '';
});

final globalValidateDataProvider =
    StateProvider.family.autoDispose<ValidateResultData, String>((ref, tag) {
  return ValidateResultData();
});

final globalBoolProvider =
    StateProvider.family.autoDispose<bool, String>((ref, tag) {
  return false;
});

final globalIndexProvider = StateProvider.family.autoDispose<int?, String>((ref, tag) {
  return null;
});
