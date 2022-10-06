import 'notification.dart';

///MARK: 觀察者

///MARK:參考網頁
/// https://flutter.cn/community/tutorials/observer-pattern-in-flutter-n-dart
class Observer {
  String name;

  Observer(this.name);

  void notify(Notification notification) {
    print("[${notification.createdTime}] Hey $name, ${notification.key}!");
  }
}