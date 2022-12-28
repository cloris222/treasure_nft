import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';

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
    return Stack(
      children: [
        Container(
            alignment: Alignment.topCenter,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: SizedBox(
                  width: UIDefine.getPixelWidth(340),
                  height: UIDefine.getHeight(),
                  child: GraduallyNetworkImage(
                      imageUrl: itemData.imageUrl, fit: BoxFit.cover),
                ))),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Text('item:$index',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: UIDefine.fontSize24,
                    fontWeight: FontWeight.w600)))
      ],
    );
  }
}
