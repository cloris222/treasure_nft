import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/airdrop/airdrop_level_boxInfo_provider.dart';
import 'package:treasure_nft_project/view_models/airdrop/airdrop_level_record_provider.dart';

import '../../constant/enum/airdrop_enum.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/api/airdrop_box_api.dart';
import '../../models/http/parameter/airdrop_box_info.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
import '../../view_models/airdrop/airdrop_count_provider.dart';
import '../../view_models/base_view_model.dart';
import 'airdrop_common_view.dart';
import 'airdrop_open_page.dart';

class AirdropGrowthPage extends ConsumerStatefulWidget {
  const AirdropGrowthPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AirdropDailyPageState();
}

class _AirdropDailyPageState extends ConsumerState<AirdropGrowthPage>
    with AirdropCommonView {
  int initLevel = 1;

  int? get preBox => ref.read(airdropLevelBoxIndexProvider(preTag));

  int? get currentBox => ref.read(airdropLevelBoxIndexProvider(currentTag));

  int? get nextBox => ref.read(airdropLevelBoxIndexProvider(nextTag));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 6; i++) {
      ref.watch(airdropLevelBoxInfoProvider(i));
      ref.watch(airdropLevelRecordProvider(i));
    }
    ref.watch(airdropLevelBoxIndexProvider(preTag));
    ref.watch(airdropLevelBoxIndexProvider(currentTag));
    ref.watch(airdropLevelBoxIndexProvider(nextTag));

    AirdropRewardInfo? rewardInfo;
    List<AirdropBoxInfo> record = [];
    if (currentBox != null) {
      rewardInfo = ref.read(airdropLevelBoxInfoProvider(currentBox!));
      record = ref.read(airdropLevelRecordProvider(currentBox!));
    }
    String orderNo = "";
    if (record.isNotEmpty) {
      orderNo = record.first.orderNo;
    }
    BoxStatus canOpenBox = checkStatus(record);
    return Container(
      decoration: AppStyle().buildAirdropBackground(),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTitleView(tr("growthProcess"), tr("upgradeChestText")),
            buildContextView(tr("upgradeChestText")),
            buildBoxView(),
            ...rewardInfo != null
                ? List<Widget>.generate(
                    rewardInfo.config.length,
                    (index) => buildRewardInfo(
                        AirdropType.growthReward, rewardInfo!.config[index]))
                : [],
            buildButton(
                canOpenBox == BoxStatus.unlocked, () => _onPressOpen(orderNo)),
            SizedBox(height: UIDefine.getPixelWidth(20)),
          ],
        ),
      ),
    );
  }

  Widget buildBoxView() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(15)),
      child: Row(
        children: [
          Expanded(child: buildBoxItem(preBox)),
          SizedBox(
              width: UIDefine.getPixelWidth(200),
              child: buildBoxItem(currentBox)),
          Expanded(child: buildBoxItem(nextBox)),
        ],
      ),
    );
  }

  Widget buildBoxItem(int? level) {
    if (level == null) {
      return const SizedBox();
    }
    bool isCurrent = (level == currentBox);
    List<AirdropBoxInfo> record = ref.read(airdropLevelRecordProvider(level));

    BoxStatus canOpenBox = checkStatus(record);
    return GestureDetector(
      onTap: () {
        onChangeIndex(ref, level);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Image.asset(format(AppImagePath.airdropBox,
                {"level": level, "status": canOpenBox.name})),
            Text("LV$level",
                style: AppTextStyle.getBaseStyle(
                  color: isCurrent ? Colors.white : Colors.grey,
                  fontSize:
                      isCurrent ? UIDefine.fontSize22 : UIDefine.fontSize12,
                  fontWeight: FontWeight.w700,
                ))
          ],
        ),
      ),
    );
  }

  void _onPressOpen(String orderNo) {
    if (currentBox != null) {
      AirdropBoxAPI().openAirdropBox(orderNo).then((list) {
        if (list.isNotEmpty) {
          BaseViewModel().pushPage(
              context, AirdropOpenPage(level: currentBox!, reward: list.first));
          ref.read(airdropLevelRecordProvider(currentBox!).notifier).update();
          ref.read(airdropCountProvider(true).notifier).update();
        }
      });
    }
  }
}
