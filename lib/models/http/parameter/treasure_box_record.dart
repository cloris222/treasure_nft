import '../../../constant/enum/airdrop_enum.dart';
import 'airdrop_box_reward.dart';

class TreasureBoxRecord {
  TreasureBoxRecord({
    required this.type,
    required this.orderNo,
    required this.createdAt,
    required this.updatedAt,
    required this.boxType,
    required this.rewardType,
    required this.medal,
    required this.itemName,
    required this.itemPrice,
    required this.imgUrl,
    required this.reward,
    required this.status,
    required this.medalName,
  });

  final String type;
  final String orderNo;
  final String createdAt;
  final String updatedAt;
  final String boxType;
  final String rewardType;
  final String medal;
  final String itemName;
  final num itemPrice;
  final String imgUrl;
  final num reward;
  final String status;
  final String medalName;

  BoxType getBoxType() {
    for (var element in BoxType.values) {
      if (boxType.compareTo(element.name) == 0) {
        return element;
      }
    }
    return BoxType.RESERVE_BOX;
  }

  AirdropBoxReward changeReward() {
    return AirdropBoxReward(
      type: type,
      orderNo: orderNo,
      createdAt: createdAt,
      updatedAt: updatedAt,
      boxType: boxType,
      rewardType: rewardType,
      medal: medal,
      medalName: medalName,
      itemName: itemName,
      itemPrice: itemPrice,
      imgUrl: imgUrl,
      reward: reward,
      status: status,
    );
  }
}
