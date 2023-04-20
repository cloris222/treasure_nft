import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/extension/num_extension.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/drop_buttom/custom_drop_button.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../constant/call_back_function.dart';
import '../../constant/enum/airdrop_enum.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/theme/app_style.dart';
import '../../models/http/parameter/airdrop_box_info.dart';
import '../../models/http/parameter/airdrop_box_reward.dart';
import '../../models/http/parameter/airdrop_reward_info.dart';
import '../../view_models/airdrop/airdrop_level_boxInfo_provider.dart';
import '../../widgets/label/gradually_network_image.dart';

class AirdropCommonView {
  final String currentTag = "currentTag";

  /// level寶箱 切換用
  void onChangeIndex(WidgetRef ref, int currentLevel) {
    if (currentLevel == 6) {
      ref.read(airdropLevelBoxIndexProvider(currentTag).notifier).state = 6;
    } else {
      ///預設顯示下一階段寶箱
      ref.read(airdropLevelBoxIndexProvider(currentTag).notifier).state =
          currentLevel;
    }
  }

  ///將獎勵類型轉為enum
  AirdropRewardType getRewardType(String type) {
    for (var element in AirdropRewardType.values) {
      if (type.compareTo(element.name) == 0) {
        return element;
      }
    }
    return AirdropRewardType.EMPTY;
  }

  ///獎勵類型的title
  String _getRewardTypeTitle(AirdropRewardType rewardType) {
    switch (rewardType) {
      case AirdropRewardType.EMPTY:
        return tr("appEmptyBox");
      case AirdropRewardType.MONEY:
        return tr("usdt");
      case AirdropRewardType.ITEM:
        return tr("nft");
      case AirdropRewardType.MEDAL:
        return tr("reserveRandomBadge");
      case AirdropRewardType.ALL:
        return "";
    }
  }

  /// 判斷獎勵寶箱的狀態
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

  /// 判斷要顯示多少獎勵物品
  List<AirdropRewardType> getRewardList(
      AirdropRewardType rewardType, bool isFlip) {
    List<AirdropRewardType> list = [];
    switch (rewardType) {
      case AirdropRewardType.EMPTY:
      case AirdropRewardType.MONEY:
      case AirdropRewardType.ITEM:
      case AirdropRewardType.MEDAL:
        list.add(rewardType);
        break;
      case AirdropRewardType.ALL:

        /// 最後顯示獎勵順序
        if (isFlip) {
          list.add(AirdropRewardType.ITEM);
          list.add(AirdropRewardType.MEDAL);
          list.add(AirdropRewardType.MONEY);
        }

        /// 寶箱開啟順序
        else {
          list.add(AirdropRewardType.MONEY);
          list.add(AirdropRewardType.MEDAL);
          list.add(AirdropRewardType.ITEM);
        }
        break;
    }
    return list;
  }

  //-----共用UI

  Widget buildTitleView(String title, String infoMessage) {
    return CustomDropButton(
        dropdownDecoration: AppStyle()
            .styleColorsRadiusBackground(color: const Color(0xFF386FDD)),
        buildCustomDropCurrentItem: (index) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 讓dropdown button 不觸發
                Flexible(
                  child: GestureDetector(
                    onTap: () {},
                    child: GradientThirdText(title,
                        weight: FontWeight.w700, size: UIDefine.fontSize20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(UIDefine.getPixelWidth(3)),
                  child: BaseIconWidget(
                      imageAssetPath: AppImagePath.airdropInfo,
                      size: UIDefine.getPixelWidth(22)),
                ),
              ],
            ),
        buildCustomDropItem: (index, needGradientText, needArrow) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title,
                  style: AppTextStyle.getBaseStyle(
                      color: Colors.white,
                      fontSize: UIDefine.fontSize16,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: UIDefine.getPixelWidth(5)),
              Expanded(
                child: Center(
                  child: Text(infoMessage,
                      textAlign: TextAlign.left,
                      style: AppTextStyle.getBaseStyle(
                          color: Colors.white,
                          fontSize: UIDefine.fontSize12,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          );
        },
        itemHeight: UIDefine.getPixelWidth(150),
        needBorderBackground: false,
        dropdownWidth: UIDefine.getWidth() * 0.87,
        initIndex: 0,
        listLength: 1,
        itemString: (index, arrow) => infoMessage,
        onChanged: (index) {});
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

  Widget buildRewardInfo(AirdropType boxType, AirdropRewardConfig data) {
    AirdropRewardType rewardType = getRewardType(data.rewardType);
    String title = "${_getRewardTypeTitle(rewardType)} : ";
    String context = "";
    switch (boxType) {
      case AirdropType.dailyReward:
        switch (rewardType) {
          case AirdropRewardType.EMPTY:
            title = tr("appEmptyBox");
            break;
          case AirdropRewardType.MONEY:
            title = "$title${data.startRange}-${data.endRange} USDT";
            break;
          case AirdropRewardType.ITEM:
            title = "$title${data.startRange}-${data.endRange} NFT";
            break;
          case AirdropRewardType.MEDAL:
            title = tr("reserveRandomBadge");
            break;
          case AirdropRewardType.ALL:
            break;
        }
        context = "${data.rate}%";
        break;
      case AirdropType.growthReward:
        switch (rewardType) {
          case AirdropRewardType.EMPTY:
            return const SizedBox();
          case AirdropRewardType.MONEY:
            context = "${data.startRange}-${data.endRange} USDT";
            break;
          case AirdropRewardType.ITEM:
            context = "${data.startRange}-${data.endRange} NFT";
            break;
          case AirdropRewardType.MEDAL:
            title = tr("commemorativeBadge");
            context = tr("randomBadge");
            break;
          case AirdropRewardType.ALL:
            break;
        }
        break;
      case AirdropType.soulPath:
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(title,
                style: AppTextStyle.getBaseStyle(
                    color: const Color(0xFF969696),
                    fontWeight: FontWeight.w400,
                    fontSize: UIDefine.fontSize14)),
          ),
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

  Widget buildStackRewardIcon(
      AirdropBoxReward reward, AirdropRewardType imgType,
      {double? size, double? fontSize}) {
    String text = "x1";
    if (imgType == AirdropRewardType.MONEY) {
      text = "+${reward.reward.removeTwoPointFormat()}";
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
      child: Stack(children: [
        buildRewardIcon(reward, imgType, size: size),
        Positioned(
            top: size == null ? UIDefine.getPixelWidth(40) : size / 2,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: AppStyle().buildGradient(
                  radius: 10,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, const Color(0xFF2D1F0A)]),
            )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Text(text,
                textAlign: TextAlign.center,
                style: AppTextStyle.getBaseStyle(
                    height: 1.1,
                    color: Colors.white,
                    fontSize: fontSize ?? UIDefine.fontSize20))),
      ]),
    );
  }

  Widget buildRewardIcon(AirdropBoxReward reward, AirdropRewardType? type,
      {double? size}) {
    if (type == null) {
      return const SizedBox();
    }
    bool assetUSDT = type == AirdropRewardType.MONEY;
    String imageUrl;
    switch (type) {
      case AirdropRewardType.ITEM:
        imageUrl = reward.imgUrl;
        break;
      case AirdropRewardType.MEDAL:
        imageUrl = reward.medal;
        break;
      default:
        imageUrl = "";
        break;
    }
    return Container(
      height: size ?? UIDefine.getPixelWidth(80),
      width: size ?? UIDefine.getPixelWidth(80),
      decoration: AppStyle().buildGradient(
          borderWith: size == null ? 3.5 : 1,
          radius: 10,
          colors: const [
            Color(0xFFF3B617),
            Color(0xFFE0C285),
            Color(0xFFB88B3D),
            Color(0xFFC96933)
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(1)),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: assetUSDT
              ? Image.asset(
                  AppImagePath.airdropUSDT,
                  fit: BoxFit.cover,
                )
              : GraduallyNetworkImage(
                  showNormal: true,
                  width: size ?? UIDefine.getPixelWidth(80),
                  height: size ?? UIDefine.getPixelWidth(80),
                  cacheWidth: 80,
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
