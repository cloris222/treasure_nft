import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../../models/http/parameter/other_collect_data.dart';
import '../../label/coin/tether_coin_widget.dart';

class OtherCollectItem extends StatelessWidget {
  const OtherCollectItem({Key? key, required this.data}) : super(key: key);
  final OtherCollectData data;

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: UIDefine.getScreenHeight(1));
    return Column(children: [
      GraduallyNetworkImage(
        imageUrl: data.nftImgUrl,
        height: UIDefine.getScreenWidth(42),
        width: UIDefine.getScreenWidth(42),
      ),
      space,
      Container(
          alignment: Alignment.centerLeft,
          child: Text(
            data.nftName,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w500),
          )),
      space,
      Row(children: [
        TetherCoinWidget(size: UIDefine.fontSize16),
        SizedBox(width: UIDefine.getScreenWidth(1)),
        Text(
          NumberFormatUtil().removeTwoPointFormat(data.nftCurrentPrice),
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
        )
      ])
    ]);
  }
}
