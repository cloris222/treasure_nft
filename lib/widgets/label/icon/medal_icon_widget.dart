import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../../constant/theme/app_image_path.dart';

class MedalIconWidget extends StatelessWidget {
  const MedalIconWidget({Key? key, required this.medal, this.size})
      : super(key: key);
  final String medal;
  final double? size;

  @override
  Widget build(BuildContext context) {
    String mainNumber = '';
    switch (medal) {

      /// 累計簽到
      case "AchSignIn":
        mainNumber = '01';
        break;

      /// 累計連續簽到
      case "AchContSignIn":
        mainNumber = '02';
        break;

      /// 累計預約成功
      case "AchRsvScs":
        mainNumber = '03';
        break;

      /// 累計購買成功
      case "AchBuyScs":
        mainNumber = '04';
        break;

      /// 累計自己購買滿額
      case "AchSlfBuyAmt":
        mainNumber = '05';
        break;

      /// 累計團隊購買次數
      case "AchTeamBuyFreq":
        mainNumber = '06';
        break;

      /// 累計團隊購買金額
      case "AchTeamBuyAmt":
        mainNumber = '07';
        break;

      /// 累計邀請有效A級
      case "AchInvClsA":
        mainNumber = '08';
        break;

      /// 累計邀請有效B或C級
      case "AchInvClsBC":
        mainNumber = '09';
        break;
    }
    String path = format(AppImagePath.medalIcon, {'mainNumber': mainNumber});
    return BaseIconWidget(imageAssetPath: path, size: size);
  }
}
