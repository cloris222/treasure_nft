import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../models/http/parameter/other_collect_data.dart';
import '../../label/coin/tether_coin_widget.dart';

class OtherCollectItem extends StatelessWidget {
  const OtherCollectItem({Key? key, required this.data}) : super(key: key);
  final OtherCollectData data;

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: UIDefine.getScreenHeight(1));
    return Column(children: [
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: GraduallyNetworkImage(
          imageUrl: data.nftImgUrl,
          width: UIDefine.getWidth(),
          height: UIDefine.getPixelWidth(100),
          fit: BoxFit.cover,
        ),
      ),
      space,
      Container(
          alignment: Alignment.centerLeft,
          child: Text(
            data.nftName,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize14,
                fontWeight: FontWeight.w600,
                color: AppColors.textThreeBlack),
          )),
      space,
      Row(children: [
        TetherCoinWidget(size: UIDefine.fontSize12),
        SizedBox(width: UIDefine.getScreenWidth(1)),
        Text(
          NumberFormatUtil().removeTwoPointFormat(data.nftCurrentPrice),
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack),
        )
      ])
    ]);
  }
}
