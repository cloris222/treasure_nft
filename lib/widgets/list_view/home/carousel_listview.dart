import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_carousel.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';

import '../../../constant/theme/app_style.dart';
import 'carousel_item.dart';

class CarouselListView extends StatefulWidget {
  const CarouselListView({super.key});

  @override
  State<StatefulWidget> createState() => _GetCarouselListView();
}

class _GetCarouselListView extends State<CarouselListView> {
  HomeMainViewModel viewModel = HomeMainViewModel();
  late List<HomeCarousel> list = [];

  List<Widget> imageList = [];

  @override
  void initState() {
    super.initState();
    viewModel.getHomeCarousel().then((value) async {
      list = value;
      await preload();
      setState(() {});

      /// to read pre load image
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? decodeHomeCarouselString =
          prefs.getStringList("homeCarousel");
      List<HomeCarousel> decodeHomeCarousel = decodeHomeCarouselString!
          .map((res) => HomeCarousel.fromJson(json.decode(res)))
          .toList();
    });
  }

  Future preload() async {
    for (int i = 0; i < list.length; i++) {
      imageList.add(Image.network(
        list[i].imageUrl,
        fit: BoxFit.cover,
      ));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('precacheImage:');
  }

  Widget createItemBuilder(BuildContext context, int index) {
    return CarouselItemView(
      itemData: list[index],
      decorationImage: imageList[index],
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
          itemCount: list.length,
          enableAutoSlider: true,
          autoSliderTransitionTime: const Duration(seconds: 1),
        ),
      ),
    );
  }
}
