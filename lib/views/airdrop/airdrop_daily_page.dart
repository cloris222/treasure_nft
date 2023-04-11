import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';

import '../../constant/enum/airdrop_enum.dart';
import '../../constant/theme/app_image_path.dart';
import '../../models/http/parameter/airdrop_box_info.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
import '../../view_models/airdrop/airdrop_daily_boxInfo_provider.dart';
import '../../view_models/airdrop/airdrop_daily_record_provider.dart';
import 'airdrop_common_view.dart';
import 'airdrop_open_page.dart';

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
    List<AirdropRewardInfo> list = ref.watch(airdropDailyBoxInfoProvider);
    List<AirdropBoxInfo> record = ref.watch(airdropDailyRecordProvider);
    BoxStatus canOpenBox = checkStatus(record);

    return Container(
      decoration: AppStyle().buildAirdropBackground(),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(15),
          vertical: UIDefine.getPixelWidth(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTitleView(tr("dailyRewards")),
            buildContextView(tr("reserveCratesInfo")),
            buildBoxView(canOpenBox),
            ...List<Widget>.generate(
                list.length,
                (index) =>
                    buildRewardInfo(AirdropType.dailyReward, list[index])),
            buildButton(canOpenBox == BoxStatus.unlocked, _onPressOpen),
            SizedBox(height: UIDefine.getPixelWidth(20)),
          ],
        ),
      ),
    );
  }

  void _onPressOpen() {
    BaseViewModel().pushPage(context, const AirdropOpenPage(level: 1));
  }

  Widget buildBoxView(BoxStatus status) {
    return Image.asset(
        format(AppImagePath.airdropBox, {"level": 0, "status": status.name}));
  }
}
