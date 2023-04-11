import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';

import '../../constant/call_back_function.dart';
import '../../constant/enum/airdrop_enum.dart';
import '../../models/http/parameter/airdrop_box_info.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
import '../../view_models/airdrop/airdrop_level_boxInfo_provider.dart';

class AirdropCommonView {
  String preTag = "preTag";
  String currentTag = "currentTag";
  String nextTag = "nextTag";

  void onChangeIndex(WidgetRef ref, int currentLevel) {
    if (currentLevel == 1 || currentLevel == 0) {
      ref.read(airdropLevelBoxIndexProvider(preTag).notifier).state = null;
      ref.read(airdropLevelBoxIndexProvider(currentTag).notifier).state = 1;
      ref.read(airdropLevelBoxIndexProvider(nextTag).notifier).state = 2;
    } else if (currentLevel == 6) {
      ref.read(airdropLevelBoxIndexProvider(preTag).notifier).state = 5;
      ref.read(airdropLevelBoxIndexProvider(currentTag).notifier).state = 6;
      ref.read(airdropLevelBoxIndexProvider(nextTag).notifier).state = null;
    } else {
      ref.read(airdropLevelBoxIndexProvider(preTag).notifier).state =
          currentLevel - 1;
      ref.read(airdropLevelBoxIndexProvider(currentTag).notifier).state =
          currentLevel;
      ref.read(airdropLevelBoxIndexProvider(nextTag).notifier).state =
          currentLevel + 1;
    }
  }

  Widget buildTitleView(String title) {
    return GradientThirdText(title,
        weight: FontWeight.w700, size: UIDefine.fontSize20);
  }

  Widget buildContextView(String context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(15)),
        child: Text(context,
            style: AppTextStyle.getBaseStyle(
                color: const Color(0xFF969696),
                fontWeight: FontWeight.w400,
                fontSize: UIDefine.fontSize12)));
  }

  Widget buildRewardInfo(AirdropType boxType, AirdropRewardInfo data) {
    AirdropRewardType rewardType = _getRewardType(data.rewardType);
    String title = "${_getRewardTypeTitle(rewardType)} : ";
    String context = "";
    switch (boxType) {
      case AirdropType.dailyReward:
        switch (rewardType) {
          case AirdropRewardType.EMPTY:
            title = title + tr("空寶箱");
            break;
          case AirdropRewardType.MONEY:
            title = "$title${data.startRange}-${data.endRange} USDT";
            break;
          case AirdropRewardType.ITEM:
            title = "$title${data.startRange}-${data.endRange} NFT";
            break;
          case AirdropRewardType.MEDAL:
            title = title + tr("随机款纪念徽章");
            break;
        }
        context = "${data.rate}%";
        break;
      case AirdropType.growthReward:
        switch (rewardType) {
          case AirdropRewardType.EMPTY:
            return const SizedBox();
            break;
          case AirdropRewardType.MONEY:
            context = "${data.startRange}-${data.endRange} USDT";
            break;
          case AirdropRewardType.ITEM:
            context = "${data.startRange}-${data.endRange} NFT";
            break;
          case AirdropRewardType.MEDAL:
            context = tr("随机款纪念徽章");
            break;
        }
        break;
      case AirdropType.soulPath:
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Row(
        children: [
          Text(title,
              style: AppTextStyle.getBaseStyle(
                  color: const Color(0xFF969696),
                  fontWeight: FontWeight.w400,
                  fontSize: UIDefine.fontSize14)),
          const Spacer(),
          Text(context,
              style: AppTextStyle.getBaseStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: UIDefine.fontSize14)),
        ],
      ),
    );
  }

  Widget buildButton(bool enable, onClickFunction onPress) {
    return LoginButtonWidget(
        radius: 22,
        btnText: tr("open"),
        onPressed: () {
          if (enable) {
            onPress();
          }
        },
        isGradient: enable,
        enable: enable,
        margin: EdgeInsets.only(top: UIDefine.getPixelWidth(15)));
  }

  AirdropRewardType _getRewardType(String type) {
    for (var element in AirdropRewardType.values) {
      if (type.compareTo(element.name) == 0) {
        return element;
      }
    }
    return AirdropRewardType.EMPTY;
  }

  String _getRewardTypeTitle(AirdropRewardType rewardType) {
    switch (rewardType) {
      case AirdropRewardType.EMPTY:
        return tr("空寶箱");
      case AirdropRewardType.MONEY:
        return tr("USDT");
      case AirdropRewardType.ITEM:
        return tr("NFT");
      case AirdropRewardType.MEDAL:
        return tr("纪念徽章");
    }
  }

  BoxStatus checkStatus(List<AirdropBoxInfo> record) {
    BoxStatus canOpenBox = BoxStatus.locked;
    if (record.isNotEmpty) {
      if (record.first.isOpen()) {
        canOpenBox = BoxStatus.opened;
      } else {
        canOpenBox = BoxStatus.unlocked;
      }
    }
    return canOpenBox;
  }
}
