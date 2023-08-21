import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 儲存未讀的站內信ID
final userLetterCountProvider = StateNotifierProvider<UserLetterCountNotifier, List<String>>((ref) {
  return UserLetterCountNotifier();
});

class UserLetterCountNotifier extends StateNotifier<List<String>> {
  UserLetterCountNotifier() : super([]);


  /// 新增
  void addLetterId(String id) {
    if (!state.contains(id)) {
      state = [...state, id];
    }
  }

  /// 刪除
  void removeLetterId(String id) {
    if (state.contains(id)) {
      var data = state;
      data.remove(id);
      state = [...data];
    }
  }

  void clear() {
    state = [];
  }
}
