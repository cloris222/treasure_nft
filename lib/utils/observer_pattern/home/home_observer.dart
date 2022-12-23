import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/utils/observer_pattern/notification.dart';
import 'package:treasure_nft_project/utils/observer_pattern/observer.dart';

class HomeObserver extends Observer {
  HomeObserver(super.name, {required this.onNotify});

  final onGetStringFunction onNotify;

  @override
  void notify(Notification notification) {
    onNotify(notification.key);
  }
}
