import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'carousel_item.dart';

class CarouselListView extends StatefulWidget {
  const CarouselListView({super.key, required this.viewModel});

  final HomeMainViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _GetCarouselListView();
}

class _GetCarouselListView extends State<CarouselListView> {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  late HomeObserver observer;

  @override
  void initState() {
    String key = SubjectKey.keyHomeCarousel;
    observer = HomeObserver(key, onNotify: (notification) {
      if (notification.key == key) {
        if (mounted) {
          setState(() {});
        }
      }
    });
    viewModel.homeSubject.registerObserver(observer);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.homeSubject.unregisterObserver(observer);
    super.dispose();
  }

  Widget createItemBuilder(BuildContext context, int index) {
    return CarouselItemView(
        itemData: viewModel.homeCarouselList[index], index: index);
  }

  @override
  Widget build(BuildContext context) {
    double itemHeight = UIDefine.getMinSize() * 0.8;
    itemHeight = itemHeight > UIDefine.getPixelWidth(360)
        ? itemHeight
        : UIDefine.getPixelWidth(360);
    return Swiper(
      autoplay: viewModel.needRecordAnimation,
      itemWidth: itemHeight * 0.8,
      itemHeight: itemHeight * 0.8,
      itemBuilder: (BuildContext context, int index) {
        return createItemBuilder(context, index);
      },
      curve: Curves.easeIn,
      itemCount: viewModel.homeCarouselList.length,
      layout: SwiperLayout.STACK,
      axisDirection: AxisDirection.right,
    );
  }
}
