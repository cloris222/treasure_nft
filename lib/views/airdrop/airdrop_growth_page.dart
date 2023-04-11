import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/airdrop/airdrop_level_boxInfo_provider.dart';
import 'package:treasure_nft_project/view_models/airdrop/airdrop_level_record_provider.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_info_provider.dart';

import '../../constant/enum/airdrop_enum.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/airdrop_box_info.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
import '../../view_models/gobal_provider/global_tag_controller_provider.dart';
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
  int initLevel = 1;

  String preTag = "preTag";
  String currentTag = "currentTag";
  String nextTag = "nextTag";

  int? get preBox => ref.read(globalIndexProvider(preTag));

  int? get currentBox => ref.read(globalIndexProvider(currentTag));

  int? get nextBox => ref.read(globalIndexProvider(nextTag));

  @override
  void initState() {
    initLevel = ref.read(userInfoProvider).level;
    if (initLevel == 0) {
      initLevel = 1;
    }
    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => _onChangeIndex(initLevel));
    for (int i = 1; i <= 6; i++) {
      ref.read(airdropLevelBoxInfoProvider(i).notifier).init();
      ref.read(airdropLevelRecordProvider(i).notifier).init();
    }

    super.initState();
  }

  void _onChangeIndex(int currentLevel) {
    if (currentLevel == 1) {
      ref.read(globalIndexProvider(preTag).notifier).state = null;
      ref.read(globalIndexProvider(currentTag).notifier).state = 1;
      ref.read(globalIndexProvider(nextTag).notifier).state = 2;
    } else if (currentLevel == 6) {
      ref.read(globalIndexProvider(preTag).notifier).state = 5;
      ref.read(globalIndexProvider(currentTag).notifier).state = 6;
      ref.read(globalIndexProvider(nextTag).notifier).state = null;
    } else {
      ref.read(globalIndexProvider(preTag).notifier).state = currentLevel - 1;
      ref.read(globalIndexProvider(currentTag).notifier).state = currentLevel;
      ref.read(globalIndexProvider(nextTag).notifier).state = currentLevel + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 1; i <= 6; i++) {
      ref.watch(airdropLevelBoxInfoProvider(i));
      ref.watch(airdropLevelRecordProvider(i));
    }
    ref.watch(globalIndexProvider(preTag));
    ref.watch(globalIndexProvider(currentTag));
    ref.watch(globalIndexProvider(nextTag));


    List<AirdropRewardInfo> list = [];
    List<AirdropBoxInfo> record = [];
    if (currentBox != null) {
      list = ref.read(airdropLevelBoxInfoProvider(currentBox!));
      record = ref.read(airdropLevelRecordProvider(currentBox!));
    }
    BoxStatus canOpenBox = checkStatus(record);
    return Container(
      decoration: AppStyle().buildAirdropBackground(),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTitleView(tr("growthProcess")),
            buildContextView(tr("升級敘述......")),
            buildBoxView(),
            ...List<Widget>.generate(
                list.length,
                (index) =>
                    buildRewardInfo(AirdropType.growthReward, list[index])),
            buildButton(canOpenBox == BoxStatus.unlocked, _onPressOpen),
          ],
        ),
      ),
    );
  }

  Widget buildBoxView() {
    return Row(
      children: [
        Expanded(child: buildBoxItem(preBox)),
        SizedBox(
            width: UIDefine.getWidth() * 0.65, child: buildBoxItem(currentBox)),
        Expanded(child: buildBoxItem(nextBox)),
      ],
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
        _onChangeIndex(level);
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

  void _onPressOpen() {}
}
