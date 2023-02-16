import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import '../../../view_models/home/provider/home_carousel_provider.dart';
import 'carousel_item.dart';

class CarouselListView extends ConsumerWidget {
  const CarouselListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double itemHeight = UIDefine.getMinSize() * 0.8;
    itemHeight = itemHeight > UIDefine.getPixelWidth(360)
        ? itemHeight
        : UIDefine.getPixelWidth(360);
    return Swiper(
      autoplay: false,
      itemWidth: itemHeight * 0.8,
      itemHeight: itemHeight * 0.8,
      itemBuilder: (BuildContext context, int index) {
        return CarouselItemView(
            itemData: ref.watch(homeCarouselListProvider)[index], index: index);
      },
      curve: Curves.easeIn,
      itemCount: ref.watch(homeCarouselListProvider).length,
      layout: SwiperLayout.STACK,
      axisDirection: AxisDirection.right,
    );
  }
}
