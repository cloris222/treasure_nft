import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';

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
  Widget build(BuildContext context) {
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
            buildRewardInfo("空寶箱", "100%"),
          ],
        ),
      ),
    );
  }
}
