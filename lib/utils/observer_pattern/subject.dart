import 'notification_data.dart';
import 'observer.dart';

///MARK: 被觀察者
class Subject {
  final List<Observer> _observers = <Observer>[];

  // 注册观察者
  void registerObserver(Observer observer) {
    _observers.add(observer);
  }

  // 解注册观察者
  void unregisterObserver(Observer observer) {
    _observers.remove(observer);
  }

  void clearObserver() {
    _observers.clear();
  }

  // 通知观察者
  void notifyObservers(NotificationData notification) {
    for (var observer in _observers) {
      observer.notify(notification);
    }
  }
}
