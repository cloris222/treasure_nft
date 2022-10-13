import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';

import 'carousel_item.dart';


class CarouselListView extends StatefulWidget {
  const CarouselListView({super.key});

  @override
  State<StatefulWidget> createState() => _GetCarouselListView();

  }

class _GetCarouselListView extends State<CarouselListView> {
  HomeMainViewModel viewModel = HomeMainViewModel();
  late List list = [];

  @override
  void initState() {
    super.initState();
    viewModel.getHomeCarousel().then((value) => {
      list = value,
      setState(() {}),
    });
  }


  Widget createItemBuilder(BuildContext context, int index) {
    return CarouselItemView(
      itemData: list[index],
    );
  }


  @override
  Widget build(BuildContext context) {
    CarouselSliderController sliderController = CarouselSliderController();
    GlobalKey<_GetCarouselListView> sliderKey = GlobalKey();

    return CarouselSlider.builder(
        key: sliderKey,
        unlimitedMode: true,
        controller: sliderController,
        slideBuilder: (index) {
          return createItemBuilder(context, index);
        },
        slideTransform: const DefaultTransform(),
        itemCount: list.length,
        enableAutoSlider: true,
        autoSliderTransitionTime:const Duration(seconds: 1),
    );
  }

}