import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';

class CarouselItemView extends StatelessWidget {
  const CarouselItemView({
    super.key,
    required this.itemData,
    required this.decorationImage,
  });

  final HomeCarousel itemData;
  final Widget decorationImage;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: decorationImage,
        ),
      ),
      Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            itemData.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )),
    ]);
  }
}
