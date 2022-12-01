import 'package:flutter/cupertino.dart';

// 底部導航欄 收藏未讀數 控制監聽
class BottomNavigationNotifier extends ChangeNotifier {
  int _unreadCount = 0;

  int get unreadCount => _unreadCount;

  set unreadCount(int value) {
    _unreadCount = value;
    notifyListeners();
  }

  minus() {
    _unreadCount--;
    notifyListeners();
  }

}