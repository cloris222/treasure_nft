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
import '../../models/http/parameter/airdrop_box_info.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
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
  int? get currentBox => ref.read(airdropLevelBoxIndexProvider(currentTag));
  late PageController controller;

  @override
  void initState() {
    controller =
        PageController(initialPage: currentBox != null ? currentBox! - 1 : 0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 6; i++) {
      ref.watch(airdropLevelBoxInfoProvider(i));
      ref.watch(airdropLevelRecordProvider(i));
    }
    ref.watch(airdropLevelBoxIndexProvider(currentTag));

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
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(15),
          vertical: UIDefine.getPixelWidth(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTitleView(tr("growthProcess"), tr("upgradeChestText")),
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
      height: UIDefine.getPixelWidth(200),
      child: PageView(
        controller: controller,
        onPageChanged: (value) {
          onChangeIndex(ref, value + 1);
        },
        children: List<Widget>.generate(6, (index) {
          int currentLevel = index + 1;
          int? preLevel = (currentLevel == 1) ? null : currentLevel - 1;
          int? nextLevel = (currentLevel == 6) ? null : currentLevel + 1;

          return Row(
            children: [
              Expanded(child: buildBoxItem(preLevel)),
              SizedBox(
                  width: UIDefine.getPixelWidth(200),
                  child: buildBoxItem(currentLevel)),
              Expanded(child: buildBoxItem(nextLevel)),
            ],
          );
        }),
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
        controller.jumpToPage(level - 1);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ref
          .read(airdropLevelRecordProvider(currentBox!).notifier)
          .openBox(context, orderNo, ref);
    }
  }
}
