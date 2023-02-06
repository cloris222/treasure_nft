import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/style_enum.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/home_artist_record.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/login/circle_network_icon.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/widgets/label/warp_two_text_widget.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import '../../../constant/theme/app_colors.dart';
import 'artist_record_item.dart';

class ArtistRecordListView extends StatefulWidget {
  const ArtistRecordListView({super.key, required this.viewModel});

  final HomeMainViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _ArtistRecordListView();
}

class _ArtistRecordListView extends State<ArtistRecordListView> {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  late HomeObserver observer;

  @override
  void initState() {
    String key = SubjectKey.keyHomeArtRecords;
    observer = HomeObserver(key, onNotify: (notification) {
      if (notification.key == SubjectKey.keyHomeArtRecords ||
          notification.key == SubjectKey.keyHomeCollectTop) {
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
    return ArtistRecordItemView(
        itemData: viewModel.homeCollectTopList[index],
        index: index,
        viewModel: viewModel,
        subjectKey: '${SubjectKey.keyHomeAnimationStart}_$index');
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
          itemCount: viewModel.homeCollectTopList.length,
          separatorBuilder: (BuildContext context, int index) {
            return createSeparatorBuilder(context, index);
          }),
      // createSeparatorBuilder(context, 1),
      SizedBox(height: UIDefine.getPixelHeight(10)),
    ]);
  }

  Widget _buildTopGallery() {
    if (viewModel.randomArt != null) {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _buildGalleryItem(viewModel.randomArt!, 0),
            SizedBox(height: UIDefine.getPixelHeight(10)),
            Row(
              children: [
                Expanded(child: _buildGalleryItem(viewModel.randomArt!, 1)),
                SizedBox(width: UIDefine.getPixelWidth(10)),
                Expanded(child: _buildGalleryItem(viewModel.randomArt!, 2)),
                SizedBox(width: UIDefine.getPixelWidth(10)),
                Expanded(child: _buildGalleryItem(viewModel.randomArt!, 3)),
              ],
            )
          ]));
    }
    return const SizedBox();
  }

  Widget _buildGalleryItem(ArtistRecord record, int index) {
    double itemHeight = UIDefine.getWidth() * 0.8;
    itemHeight = itemHeight > UIDefine.getPixelWidth(390)
        ? itemHeight
        : UIDefine.getPixelWidth(390);

    double? imageSize = (index == 0 ? itemHeight : null);

    return record.imgInfo.length > index
        ? Column(mainAxisSize: MainAxisSize.min, children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: GraduallyNetworkImage(
                        imageUrl: record.imgInfo[index].imgUrl,
                        fit: BoxFit.cover))),
            SizedBox(height: UIDefine.getPixelWidth(10)),
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
                          text: record.imgInfo[index].name,
                          fontWeight: FontWeight.w600,
                          fontSize: UIDefine.fontSize16,
                          family: AppTextFamily.PosteramaText,
                          maxLines: 2),
                    ),
                    SizedBox(width: UIDefine.getPixelWidth(30)),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(tr('highestBid'),
                              style: AppTextStyle.getBaseStyle(
                                  fontSize: UIDefine.fontSize10,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: UIDefine.getPixelHeight(5)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TetherCoinWidget(size: UIDefine.fontSize14),
                                SizedBox(width: UIDefine.getPixelWidth(3)),
                                Text(
                                  '${BaseViewModel().numberCompatFormat(record.imgInfo[index].currentPrice.toString())} USDT',
                                  style: AppTextStyle.getBaseStyle(
                                      fontSize: UIDefine.fontSize12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppTextFamily.PosteramaText),
                                )
                              ])
                        ])
                  ])
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WarpTwoTextWidget(
                          text: record.imgInfo[index].name,
                          fontWeight: FontWeight.w600,
                          fontSize: UIDefine.fontSize14,
                          family: AppTextFamily.PosteramaText,
                          maxLines: 2),
                      SizedBox(height: UIDefine.getPixelWidth(5)),
                      Row(
                        children: [
                          SizedBox(
                              width: UIDefine.getPixelWidth(25),
                              height: UIDefine.getPixelWidth(25),
                              child: CircleNetworkIcon(
                                  networkUrl: record.avatarUrl)),
                          SizedBox(width: UIDefine.getPixelWidth(5)),
                          Container(
                            decoration: AppStyle().styleColorBorderBackground(
                                radius: 8, color: AppColors.tetherGreen),
                            padding: EdgeInsets.all(UIDefine.getPixelWidth(5)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TetherCoinWidget(
                                      size: UIDefine.getPixelWidth(15)),
                                  SizedBox(width: UIDefine.getPixelWidth(3)),
                                  Text(
                                    BaseViewModel().numberCompatFormat(record
                                        .imgInfo[index].currentPrice
                                        .toString()),
                                    style: AppTextStyle.getBaseStyle(
                                        color: AppColors.tetherGreen,
                                        fontSize: UIDefine.fontSize10,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            AppTextFamily.PosteramaText),
                                  )
                                ]),
                          )
                        ],
                      ),
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
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize18,
                  fontWeight: FontWeight.w900,
                  fontFamily: AppTextFamily.Posterama1927)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tr('Last_24_hours'),
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textNineBlack,
                      fontFamily: AppTextFamily.PosteramaText)),
              GestureDetector(
                  onTap: () => viewModel.pushPage(context,
                      const MainPage(type: AppNavigationBarType.typeExplore)),
                  child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tr('more'),
                              style: AppTextStyle.getBaseStyle(
                                  fontSize: UIDefine.fontSize14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppTextFamily.PosteramaText)),
                          Image.asset(AppImagePath.arrowRight)
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
