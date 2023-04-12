import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/extension/num_extension.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/views/airdrop/airdrop_common_view.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../constant/enum/airdrop_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/treasure_box_record.dart';
import '../../view_models/base_view_model.dart';

class TreasureBoxCard extends StatelessWidget with AirdropCommonView {
  TreasureBoxCard({Key? key, required this.record}) : super(key: key);
  final TreasureBoxRecord record;

  @override
  Widget build(BuildContext context) {
    BoxType boxType = record.getBoxType();
    AirdropRewardType rewardType = getRewardType(record.rewardType);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          BaseViewModel().changeTimeZone(record.createdAt),
          style: AppTextStyle.getBaseStyle(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
          child: Row(children: [
            buildBoxImage(boxType.index),
            SizedBox(width: UIDefine.getPixelWidth(5)),
            Expanded(child: buildBoxType(boxType, rewardType)),
          ]),
        ),
        Container(
            width: double.infinity, height: 1, color: AppColors.searchBar),
      ],
    );
  }

  Widget buildBoxImage(int level) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        decoration: level == 0
            ? AppStyle().buildGradient(
                colors: const [Color(0xFFBAD46E), Color(0xFFE9FFAA)])
            : const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagePath.airdropAnimateBg),
                    fit: BoxFit.cover)),
        height: UIDefine.getPixelWidth(60),
        width: UIDefine.getPixelWidth(60),
        child: Image.asset(format(AppImagePath.airdropBox,
            {"level": level, "status": BoxStatus.unlocked.name})),
      ),
    );
  }

  Widget buildBoxType(BoxType boxType, AirdropRewardType rewardType) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                boxType == BoxType.RESERVE_BOX
                    ? tr("appTypeReserveBox")
                    : tr("appTypeLevelBox"),
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize12,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: UIDefine.getPixelWidth(10)),
            buildType(rewardType),
          ],
        ),
        Expanded(
            child: Container(
                alignment: Alignment.centerRight,
                child: buildReward(boxType, rewardType))),
        SizedBox(width: UIDefine.getPixelWidth(10)),
      ],
    );
  }

  Widget buildType(AirdropRewardType rewardType) {
    Color color;
    String? imageAsset;
    String title;
    switch (rewardType) {
      case AirdropRewardType.EMPTY:
        color = const Color(0xFF979797);
        title = tr("appEmptyBox");
        break;
      case AirdropRewardType.MONEY:
        color = const Color(0xFF32A071);
        title = tr("usdt");
        imageAsset = AppImagePath.tetherImg;
        break;
      case AirdropRewardType.ITEM:
        color = const Color(0xFF72B8F9);
        title = tr("nft");
        break;
      case AirdropRewardType.MEDAL:
        color = const Color(0xFF72B8F9);
        title = tr("appMedal");
        break;
      case AirdropRewardType.ALL:
        color = const Color(0xFFFF8F28);
        title = tr("growthProcess");
        break;
    }

    return Container(
      decoration:
          AppStyle().styleColorBorderBackground(color: color, radius: 2),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          imageAsset != null
              ? Padding(
                  padding: EdgeInsets.only(right: UIDefine.getPixelWidth(5)),
                  child: BaseIconWidget(
                    imageAssetPath: imageAsset,
                    size: UIDefine.getPixelWidth(15),
                  ),
                )
              : const SizedBox(),
          Text(title,
              style: AppTextStyle.getBaseStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: UIDefine.fontSize10)),
        ],
      ),
    );
  }

  Widget buildReward(BoxType boxType, AirdropRewardType rewardType) {
    switch (rewardType) {
      case AirdropRewardType.EMPTY:
        return Text("--",
            style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12,
              fontWeight: FontWeight.w600,
            ));
      case AirdropRewardType.MONEY:
        return Text("+ ${record.reward.removeTwoPointFormat()} ${tr("usdt")}",
            style: AppTextStyle.getBaseStyle(
              color: const Color(0xFF32A071),
              fontSize: UIDefine.fontSize16,
              fontWeight: FontWeight.w600,
            ));
      case AirdropRewardType.ITEM:
        return GraduallyNetworkImage(
            imageUrl: record.imgUrl,
            height: UIDefine.getPixelWidth(48),
            width: UIDefine.getPixelWidth(48),
            fit: BoxFit.cover);
      case AirdropRewardType.MEDAL:
        return GraduallyNetworkImage(
            imageUrl: record.medal,
            height: UIDefine.getPixelWidth(48),
            width: UIDefine.getPixelWidth(48),
            fit: BoxFit.cover);
      case AirdropRewardType.ALL:
        return Text("${tr("appSellMore")} >",
            style: AppTextStyle.getBaseStyle(
                color: const Color(0xFF828282),
                fontWeight: FontWeight.w500,
                fontSize: UIDefine.fontSize12));
    }
  }
}
