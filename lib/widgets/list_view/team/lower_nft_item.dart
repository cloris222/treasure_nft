import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/lower_nft_data.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

import '../../../views/personal/team/team_main_style.dart';

class LowerNFTItemView extends StatefulWidget {
  const LowerNFTItemView({super.key, required this.itemData});

  final LowerNftData itemData;

  @override
  State<StatefulWidget> createState() => _LowerNFTItem();
}

class _LowerNFTItem extends State<LowerNFTItemView> {
  TeamMainStyle style = TeamMainStyle();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(UIDefine.getScreenWidth(3)),
        decoration: AppStyle().styleColorsRadiusBackground(
            color: AppColors.itemBackground, radius: 4),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: SizedBox(
                  width: UIDefine.getPixelWidth(80),
                  height: UIDefine.getPixelWidth(80),
                  child: GraduallyNetworkImage(
                    imageUrl: widget.itemData.originImgUrl,
                    width: UIDefine.getScreenWidth(19.5),
                    height: UIDefine.getScreenWidth(19.5),
                  ),
                ),
              ),
              SizedBox(width: UIDefine.getPixelWidth(15)),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemData.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack),
                  ),
                  SizedBox(height: UIDefine.getPixelWidth(15)),
                  Row(
                    children: [
                      SizedBox(
                        height: UIDefine.getPixelWidth(12),
                        child: Image.asset(AppImagePath.tetherImg),
                      ),
                      style.getPadding(1),
                      Text(
                        widget.itemData.currentPrice.toString(),
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBlack),
                      ),
                    ],
                  )
                ],
              ))
            ]));
  }
}
