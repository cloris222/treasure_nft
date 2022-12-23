import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/widgets/list_view/home/carousel_item.dart';

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
    observer = HomeObserver(key, onNotify: (notificationKey) {
      if (notificationKey == key) {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GlobalData.printLog('precacheImage:');
  }

  Widget createItemBuilder(BuildContext context, int index) {
    return CarouselItemView(
      itemData: viewModel.homeCarouselList[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    CarouselSliderController sliderController = CarouselSliderController();
    GlobalKey<_GetCarouselListView> sliderKey = GlobalKey();
    double itemHeight = UIDefine.getWidth() * 0.8;

    return SizedBox(
      height: itemHeight > 430 ? itemHeight : 430,
      child: Container(
        /// 0px 6px 5px rgba(9, 9, 9, 0.15);
        decoration: AppStyle().styleShadowBorderBackground(
            borderWidth: 0,
            radius: 20,
            borderColor: Colors.transparent,
            offsetX: 0,
            offsetY: 6,
            blurRadius: 5,
            shadowColor: const Color(0xFF090909).withOpacity(0.15)),
        child: CarouselSlider.builder(
          key: sliderKey,
          unlimitedMode: true,
          controller: sliderController,
          slideBuilder: (index) {
            return createItemBuilder(context, index);
          },
          slideTransform: const DefaultTransform(),
          itemCount: viewModel.homeCarouselList.length,
          enableAutoSlider: true,
          autoSliderTransitionTime: const Duration(seconds: 1),
        ),
      ),
    );
  }
}
