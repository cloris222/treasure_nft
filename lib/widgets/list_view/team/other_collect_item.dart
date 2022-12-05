import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';

import '../../../models/http/parameter/other_collect_data.dart';
import '../../label/coin/tether_coin_widget.dart';

class OtherCollectItem extends StatelessWidget {
  const OtherCollectItem({Key? key, required this.data}) : super(key: key);
  final OtherCollectData data;

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: UIDefine.getScreenHeight(1));
    return Column(children: [
      CachedNetworkImage(
        imageUrl: data.nftImgUrl,
        height: UIDefine.getScreenWidth(42),
        width: UIDefine.getScreenWidth(42),
        errorWidget: (context, url, error) => const Icon(Icons.cancel_rounded),
      ),
      space,
      Container(
          alignment: Alignment.centerLeft,
          child: Text(
            data.nftName,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w600),
          )),
      space,
      Row(children: [
        TetherCoinWidget(size: UIDefine.fontSize16),
        SizedBox(width: UIDefine.getScreenWidth(1)),
        Text(
          NumberFormatUtil().removeTwoPointFormat(data.nftCurrentPrice),
          style: TextStyle(
              fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500),
        )
      ])
    ]);
  }
}
