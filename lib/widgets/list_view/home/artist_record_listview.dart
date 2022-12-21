import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/login/circle_network_icon.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/widgets/label/warp_two_text_widget.dart';
import '../../../constant/theme/app_colors.dart';
import 'artist_record_item.dart';

class ArtistRecordListView extends StatefulWidget {
  const ArtistRecordListView(
      {super.key, required this.showArtAnimate, required this.viewModel});

  final bool showArtAnimate;
  final HomeMainViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _ArtistRecordListView();
}

class _ArtistRecordListView extends State<ArtistRecordListView> {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  List artList = [];
  int animateIndex = -1;
  ArtistRecord? randomArt;

  ///MARK: 收藏集排行
  List collectList = [];

  @override
  void didUpdateWidget(covariant ArtistRecordListView oldWidget) {
    if (widget.showArtAnimate != oldWidget.showArtAnimate) {
      if (widget.showArtAnimate) {
        _playAnimate();
      } else {
        setState(() {
          animateIndex = -1;
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    viewModel.getArtistRecord().then((value) => {
          artList = value,
          randomArt = artList[Random().nextInt(artList.length)],
          setState(() {}),
        });
    viewModel.getCollectTop().then((value) => setState(() {
          collectList = value;
        }));
  }

  Widget createItemBuilder(BuildContext context, int index) {
    return ArtistRecordItemView(
        itemData: collectList[index],
        showAnimate: animateIndex >= index,
        index: index);
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Divider(height: 5, color: AppColors.bolderGrey, thickness: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(height: UIDefine.getPixelHeight(20)),
      _buildTopGallery(),
      _buildArtistTitle(),
      ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return createItemBuilder(context, index);
          },
          itemCount: collectList.length,
          separatorBuilder: (BuildContext context, int index) {
            return createSeparatorBuilder(context, index);
          }),
      // createSeparatorBuilder(context, 1),
      SizedBox(height: UIDefine.getPixelHeight(10)),
    ]);
  }

  void _playAnimate() async {
    _loopAnimate();
  }

  _loopAnimate() {
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      setState(() {
        animateIndex += 1;
      });
      if (animateIndex < artList.length) {
        _loopAnimate();
      }
    });
  }

  Widget _buildTopGallery() {
    if (randomArt != null) {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _buildGalleryItem(randomArt!, 0),
            SizedBox(height: UIDefine.getPixelHeight(10)),
            Row(
              children: [
                Expanded(child: _buildGalleryItem(randomArt!, 1)),
                SizedBox(width: UIDefine.getPixelWidth(10)),
                Expanded(child: _buildGalleryItem(randomArt!, 2)),
                SizedBox(width: UIDefine.getPixelWidth(10)),
                Expanded(child: _buildGalleryItem(randomArt!, 3)),
              ],
            )
          ]));
    }
    return const SizedBox();
  }

  Widget _buildGalleryItem(ArtistRecord record, int index) {
    return record.imgUrl.length > index
        ? Column(mainAxisSize: MainAxisSize.min, children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: GraduallyNetworkImage(imageUrl: record.imgUrl[index])),
            SizedBox(height: UIDefine.getPixelHeight(5)),
            index == 0
                ? Row(children: [
                    SizedBox(
                      width: UIDefine.getPixelWidth(30),
                      height: UIDefine.getPixelWidth(30),
                      child: CircleNetworkIcon(
                          networkUrl: record.avatarUrl,
                          radius: UIDefine.getPixelHeight(15)),
                    ),
                    SizedBox(width: UIDefine.getPixelWidth(3)),
                    Expanded(
                      child: WarpTwoTextWidget(
                          text: record.name,
                          fontWeight: FontWeight.w500,
                          fontSize: UIDefine.fontSize16,
                          maxLines: 1),
                    ),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(tr('highestBid')),
                          SizedBox(height: UIDefine.getPixelHeight(5)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TetherCoinWidget(size: UIDefine.fontSize16),
                                SizedBox(width: UIDefine.getPixelWidth(3)),
                                Text(
                                  '${BaseViewModel().numberCompatFormat(record.baseYdayAmt)} USDT',
                                  style: TextStyle(
                                      fontSize: UIDefine.fontSize14,
                                      fontWeight: FontWeight.w500),
                                )
                              ])
                        ])
                  ])
                : Row(
                    children: [
                      Flexible(
                          child: SizedBox(
                              width: UIDefine.getPixelWidth(30),
                              height: UIDefine.getPixelWidth(30),
                              child: CircleNetworkIcon(
                                  networkUrl: record.avatarUrl))),
                      SizedBox(width: UIDefine.getPixelWidth(5)),
                      Container(
                        decoration: AppStyle().styleColorBorderBackground(
                            radius: 8, color: AppColors.tetherGreen),
                        padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TetherCoinWidget(size: UIDefine.fontSize10),
                              SizedBox(width: UIDefine.getPixelWidth(3)),
                              Text(
                                '${BaseViewModel().numberCompatFormat(record.baseYdayAmt)} USDT',
                                style: TextStyle(
                                    color: AppColors.tetherGreen,
                                    fontSize: UIDefine.getPixelHeight(9),
                                    fontWeight: FontWeight.w500),
                              )
                            ]),
                      )
                    ],
                  ),
            SizedBox(height: UIDefine.getPixelHeight(5)),
          ])
        : const SizedBox();
  }

  Widget _buildArtistTitle() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(20),
          vertical: UIDefine.getPixelHeight(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('top-creator'),
              style: TextStyle(
                  fontSize: UIDefine.fontSize16, fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tr('Last_24_hours'),
                  style: TextStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.homeGrey)),
              GestureDetector(
                  onTap: () => viewModel.pushPage(context,
                      const MainPage(type: AppNavigationBarType.typeExplore)),
                  child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tr('more'),
                              style: TextStyle(
                                  fontSize: UIDefine.fontSize14,
                                  fontWeight: FontWeight.w500)),
                          Image.asset(AppImagePath.rightArrow)
                        ],
                      )))
              // LoginBolderButtonWidget(
              //     radius: 40,
              //     textSize: UIDefine.fontSize14,
              //     fontWeight: FontWeight.w500,
              //     height: UIDefine.getPixelHeight(30),
              //     width: UIDefine.getPixelWidth(100),
              //     btnText: tr('more'),
              //     onPressed: () => viewModel.pushPage(context,
              //         const MainPage(type: AppNavigationBarType.typeExplore)))
            ],
          )
        ],
      ),
    );
  }
}
