import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

class CarouselItemView extends StatelessWidget {
  const CarouselItemView({
    super.key,
    required this.itemData,
  });

  final HomeCarousel itemData;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Container(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: GraduallyNetworkImage(
                width: UIDefine.getPixelWidth(340),
                height: UIDefine.getHeight(),
                imageUrl: itemData.imageUrl,
                fit: BoxFit.cover),
          ),
        ),
      ),
      Container(
          height: UIDefine.getPixelHeight(50),
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            itemData.name,
            style: TextStyle(
              fontSize: UIDefine.fontSize16,
              fontWeight: FontWeight.w400,
            ),
          )),
    ]);
  }
}
