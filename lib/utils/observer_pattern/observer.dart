import 'notification_data.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
///MARK: 觀察者

///MARK:參考網頁
/// https://flutter.cn/community/tutorials/observer-pattern-in-flutter-n-dart
class Observer {
  String name;

  Observer(this.name);

  void notify(NotificationData notification) {
    GlobalData.printLog("[${notification.createdTime}] Hey $name, ${notification.key}!");
  }
}