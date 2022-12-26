class NotificationData {
  NotificationData({required this.key, this.data}) {
    createdTime = DateTime.now();
  }

  late DateTime createdTime;
  dynamic data;
  String key;
}
