import '../../constant/enum/level_enum.dart';

class TradeData{
  TradeData({required this.duration, required this.status});
  SellingState status;
  Duration duration;
}