import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/views/login/circle_network_icon.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';

class CarouselItemView extends StatelessWidget {
  const CarouselItemView({
    super.key,
    required this.itemData,
    required this.index,
  });

  final HomeCarousel itemData;
  final int index;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize10,
        fontWeight: FontWeight.w400,
        color: AppColors.textWhite);
    TextStyle contextStyle = AppTextStyle.getBaseStyle(
        fontSize: UIDefine.fontSize12,
        fontWeight: FontWeight.w600,
        color: AppColors.textWhite,
        fontFamily: AppTextFamily.Posterama1927);

    return Stack(
      children: [
        Container(
            alignment: Alignment.topCenter,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: SizedBox.expand(
                  child: GraduallyNetworkImage(
                      imageUrl: itemData.imageUrl, fit: BoxFit.cover),
                ))),
        Positioned(
            top: UIDefine.getPixelWidth(10),
            left: UIDefine.getPixelWidth(10),
            bottom: UIDefine.getPixelWidth(10),
            right: UIDefine.getPixelWidth(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemData.name,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textWhite)),
                SizedBox(height: UIDefine.getPixelWidth(5)),
                Row(children: [
                  CircleNetworkIcon(networkUrl: itemData.avatarUrl, radius: 15),
                  SizedBox(width: UIDefine.getPixelWidth(8)),
                  Text(itemData.creator,
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textWhite))
                ]),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: AppStyle().styleColorsRadiusBackground(
                      color: const Color(0xFF756E91), radius: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Bid', style: titleStyle),
                            SizedBox(height: UIDefine.getPixelWidth(5)),
                            Row(children: [
                              TetherCoinWidget(
                                  size: UIDefine.getPixelWidth(15)),
                              SizedBox(width: UIDefine.getPixelWidth(5)),
                              Text(
                                  '${NumberFormatUtil().removeTwoPointFormat(itemData.currentPrice)} USDT',
                                  style: contextStyle)
                            ])
                          ]),
                      const Spacer(),
                      Visibility(
                        visible: itemData.startTime.isNotEmpty,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ends in', style: titleStyle),
                            SizedBox(height: UIDefine.getPixelWidth(5)),
                            Text(
                                itemData.startTime.isNotEmpty
                                    ? DateFormatUtil().getDiffTime(DateTime.parse(
                                        '${DateFormatUtil().getNowTimeWithDayFormat()} ${itemData.startTime}'))
                                    : '',
                                style: contextStyle)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
