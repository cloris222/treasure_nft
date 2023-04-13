import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

import '../../constant/enum/airdrop_enum.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/parameter/airdrop_box_info.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
import '../../view_models/airdrop/airdrop_daily_boxInfo_provider.dart';
import '../../view_models/airdrop/airdrop_daily_record_provider.dart';
import 'airdrop_common_view.dart';

class AirdropDailyPage extends ConsumerStatefulWidget {
  const AirdropDailyPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AirdropDailyPageState();
}

class _AirdropDailyPageState extends ConsumerState<AirdropDailyPage>
    with AirdropCommonView {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AirdropRewardInfo? rewardInfo = ref.watch(airdropDailyBoxInfoProvider);
    List<AirdropBoxInfo> record = ref.watch(airdropDailyRecordProvider);
    BoxStatus canOpenBox = checkStatus(record);
    String orderNo = "";
    if (record.isNotEmpty) {
      orderNo = record.first.orderNo;
    }

    return Container(
      decoration: AppStyle().buildAirdropBackground(),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(15),
          vertical: UIDefine.getPixelWidth(20)),
      child: Column(
        children: [
          buildTitleView(tr("dailyRewards"), tr("dailyRewardsInfoText")),
          buildContextView(tr("reserveCratesInfo")),
          Flexible(child: buildBoxView(canOpenBox)),
          ...rewardInfo != null
              ? List<Widget>.generate(
                  rewardInfo.config.length,
                  (index) => buildRewardInfo(
                      AirdropType.dailyReward, rewardInfo.config[index]))
              : [],
          buildButton(
              canOpenBox == BoxStatus.unlocked, () => _onPressOpen(orderNo)),
          SizedBox(height: UIDefine.getPixelWidth(20)),
        ],
      ),
    );
  }

  void _onPressOpen(String orderNo) async {
    ref.read(airdropDailyRecordProvider.notifier).openBox(context, orderNo, ref);
  }

  Widget buildBoxView(BoxStatus status) {
    return Image.asset(
        format(AppImagePath.airdropBox, {"level": 0, "status": status.name}));
  }
}
