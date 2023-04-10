import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/view_models/airdrop/airdrop_level_boxInfo_provider.dart';
import 'package:treasure_nft_project/view_models/airdrop/airdrop_level_record_provider.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';

import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import 'airdrop_common_view.dart';

class AirdropGrowthPage extends ConsumerStatefulWidget {
  const AirdropGrowthPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AirdropDailyPageState();
}

class _AirdropDailyPageState extends ConsumerState<AirdropGrowthPage>
    with AirdropCommonView {
  int currentLevel = 0;

  @override
  void initState() {
    currentLevel = ref.read(userInfoProvider).level;
    ref.read(airdropLevelBoxInfoProvider(currentLevel).notifier).init();
    ref.read(airdropLevelRecordProvider(currentLevel).notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().buildAirdropBackground(),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTitleView(tr("dailyRewards")),
            buildContextView(tr("reserveCratesInfo")),

          ],
        ),
      ),
    );
  }
}
