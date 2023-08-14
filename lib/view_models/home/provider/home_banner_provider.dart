import 'package:flutter_riverpod/flutter_riverpod.dart';

final bannerSecondsProvider = StateProvider.autoDispose<String>((ref) {
  return "2";
});