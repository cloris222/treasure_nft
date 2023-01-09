import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:treasure_nft_project/constant/subject_key.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/discover_collect_data.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/utils/observer_pattern/home/home_observer.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/explore/data/explore_category_response_data.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/gradually_network_image.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

class HomeSubDiscoverNftView extends StatefulWidget {
  const HomeSubDiscoverNftView({Key? key, required this.viewModel})
      : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  State<HomeSubDiscoverNftView> createState() => _HomeSubDiscoverNftViewState();
}

class _HomeSubDiscoverNftViewState extends State<HomeSubDiscoverNftView> {
  HomeMainViewModel get viewModel {
    return widget.viewModel;
  }

  late PageController pageController;
  ItemScrollController listController = ItemScrollController();
  late HomeObserver observer;
  List<Widget> pages = [];

  @override
  void initState() {
    pageController =
        PageController(initialPage: getExploreTypeIndex(viewModel.currentTag));
    String key = SubjectKey.keyHomeDiscoverData;
    observer = HomeObserver(key, onNotify: (notification) {
      if (notification.key == SubjectKey.keyHomeDiscoverData ||
          notification.key == SubjectKey.keyHomeDiscoverTags) {
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
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().buildGradient(
          radius: 0, colors: AppColors.gradientBackgroundColorBg),
      padding: viewModel.getMainPadding(width: 20, height: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin:
                  EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(10)),
              child: Text(tr('discoverNfts'),
                  style: viewModel.getMainTitleStyle())),
          _buildTags(),
          SizedBox(
              height: UIDefine.getPixelHeight(getPageHeight().toDouble()),
              child: PageView(
                  controller: pageController,
                  onPageChanged: _onPageChange,
                  children: List<Widget>.generate(
                      viewModel.tags.length, (index) => _buildListView()))),
          _buildMoreButton()
        ],
      ),
    );
  }

  num getPageHeight() {
    if (viewModel.discoverList.isEmpty) {
      return 185 * 4;
    }
    return 185 *
        (viewModel.discoverList.length ~/ 2 +
            viewModel.discoverList.length % 2);
  }

  void _onPageChange(int value) {
    if (getExploreTypeIndex(viewModel.currentTag) != value) {
      changePage(viewModel.tags[value]);
    }
  }

  void changePage(ExploreCategoryResponseData exploreType) {
    setState(() {
      viewModel.currentTag = exploreType;
      pageController.jumpToPage(getExploreTypeIndex(exploreType));
      viewModel.discoverList = [];
    });
    viewModel.getDiscoverList(viewModel.currentTag);
  }

  int getExploreTypeIndex(ExploreCategoryResponseData type) {
    for (int i = 0; i < viewModel.tags.length; i++) {
      if (type.frontName == viewModel.tags[i].frontName) {
        return i;
      }
    }
    return -1;
  }

  Widget _buildTags() {
    return Container(
        alignment: Alignment.center,
        height: UIDefine.getPixelWidth(25),
        margin: EdgeInsets.only(bottom: UIDefine.getPixelWidth(20)),
        child: ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal,
            itemScrollController: listController,
            itemCount: viewModel.tags.length,
            itemBuilder: (context, index) {
              return _buildTabButton(viewModel.tags[index]);
            }));
  }

  Widget _buildTabButton(ExploreCategoryResponseData type) {
    bool isCurrent = (type.frontName == viewModel.currentTag.frontName);

    return GestureDetector(
        onTap: () {
          changePage(type);
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: UIDefine.getPixelWidth(15),
                vertical: UIDefine.getPixelWidth(3)),
            margin: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
            decoration: _getButtonBackground(isCurrent),
            child: Text(
              type.getTabTitle(),
              style: AppTextStyle.getBaseStyle(
                  color: _getButtonColor(isCurrent),
                  fontSize: UIDefine.fontSize12,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            )));
  }

  BoxDecoration _getButtonBackground(bool isCurrent) {
    if (isCurrent) return AppStyle().baseGradient(radius: 11);
    return AppStyle().styleColorsRadiusBackground(
        color: const Color(0xFFEFEFEF), radius: 11);
  }

  Color _getButtonColor(bool isCurrent) {
    if (isCurrent) return Colors.white;
    return Colors.black;
  }

  Widget _buildListView() {
    if (viewModel.discoverList.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: UIDefine.getPixelHeight(10)),
          LoadingAnimationWidget.hexagonDots(
              color: AppColors.textBlack, size: 30)
        ],
      );
    }

    List<List<Widget>> lists = [];
    int nListCount = (viewModel.discoverList.isNotEmpty)
        ? viewModel.discoverList.length ~/ 2
        : 0;
    for (int i = 0; i < nListCount; i++) {
      List<Widget> row = [];
      row.add(Expanded(child: createItemBuilder(context, i * 2)));
      row.add(Expanded(child: createItemBuilder(context, i * 2 + 1)));
      lists.add(row);
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lists[index]);
      },
      itemCount: lists.length,
      separatorBuilder: (BuildContext context, int index) {
        return createSeparatorBuilder(context, index);
      },
    );
  }

  Widget createItemBuilder(BuildContext context, int index) {
    if (index >= viewModel.discoverList.length) {
      return const SizedBox(height: 100);
    }
    return getExploreListViewItem(viewModel.discoverList[index], index);
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return SizedBox(height: UIDefine.getScreenWidth(1));
  }

  int getItemCount() {
    return viewModel.discoverList.length;
  }

  Widget getExploreListViewItem(DiscoverCollectData data, int index) {
    return Container(
        decoration: AppStyle().styleColorsRadiusBackground(),
        margin: EdgeInsets.all(UIDefine.getPixelHeight(5)),
        padding: EdgeInsets.all(UIDefine.getPixelHeight(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: SizedBox(
                    width: UIDefine.getWidth(),
                    height: UIDefine.getPixelHeight(100),
                    child: GraduallyNetworkImage(
                        imageUrl: data.imgUrl, fit: BoxFit.cover))),
            Container(
                margin:
                    EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(5)),
                alignment: Alignment.centerLeft,
                child: Text(data.name,
                    maxLines: 1,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBlack))),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(5)),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  TetherCoinWidget(size: UIDefine.getPixelWidth(14)),
                  Text(
                      ' ${NumberFormatUtil().removeTwoPointFormat(data.currentPrice)} USDT',
                      style: AppTextStyle.getBaseStyle(
                          fontSize: UIDefine.fontSize12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.tetherGreen))
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildMoreButton() {
    return InkWell(
        onTap: () {
          viewModel.pushAndRemoveUntil(
              context, const MainPage(type: AppNavigationBarType.typeExplore));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelHeight(15)),
          padding: EdgeInsets.symmetric(
              vertical: UIDefine.getPixelWidth(5),
              horizontal: UIDefine.getPixelWidth(10)),
          decoration: AppStyle().styleColorBorderBackground(
            borderLine: 1,
            radius: 14,
            backgroundColor: Colors.transparent,
            color: AppColors.textNineBlack,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${tr('more')} NFTs',
                style: viewModel.getContextStyle(fontWeight: FontWeight.w600),
              ),
              BaseIconWidget(
                  imageAssetPath: AppImagePath.arrowRightBlack,
                  size: UIDefine.getPixelWidth(20))
            ],
          ),
        ));
  }
}
