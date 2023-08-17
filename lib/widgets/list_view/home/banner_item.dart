import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_banner_data.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';


class BannerItemView extends StatelessWidget {
  const BannerItemView({
    super.key,
    required this.itemData,
  });

  final BannerData itemData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: GestureDetector(
          onTap: ()=> BaseViewModel().launchInBrowser(itemData.externalUrl),
          child:GraduallyNetworkImage(
              onlyShowNormal:true,
              imageUrl:itemData.viewMb,
              cacheWidth: 360,
              width: UIDefine.getPixelWidth(360),
              height: UIDefine.getPixelWidth(170),
              fit: BoxFit.cover),
        )

    );
  }
}
