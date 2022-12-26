import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/utils/observer_pattern/notification_data.dart';
import 'package:treasure_nft_project/utils/observer_pattern/observer.dart';

class HomeObserver extends Observer {
  HomeObserver(super.name, {required this.onNotify});

  final NotificationDataFunction onNotify;

  @override
  void notify(NotificationData notification) {
    onNotify(notification);
  }
}
