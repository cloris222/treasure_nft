import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/discover_collect_data.dart';
import 'package:treasure_nft_project/view_models/home/home_main_viewmodel.dart';
import 'package:treasure_nft_project/views/explore/data/explore_category_response_data.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyle().buildGradient(
          radius: 0, colors: AppColors.gradientBackgroundColorBg),
      padding: viewModel.getMainPadding(width: 30, height: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tr('discoverNfts'), style: viewModel.getMainTitleStyle()),
          _buildTags(),
          _buildListView()
        ],
      ),
    );
  }

  Widget _buildTags() {
    // return getExploreTypeButtons(currentExploreType: '',dataList: viewModel.tags,);
    return Container();
  }

  Widget getExploreTypeButtons(
      {required String currentExploreType,
      required List<ExploreCategoryResponseData> dataList,
      required ItemScrollController controller,
      required Function(String exploreType) changePage}) {
    List<Widget> buttons = <Widget>[];
    for (int i = 0; i < dataList.length; i++) {
      bool isCurrent = (dataList[i].name == currentExploreType);
      buttons.add(
        SizedBox(
          height: UIDefine.getScreenWidth(12),
          child: TextButton(
            onPressed: () {
              changePage(dataList[i].name);
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(2.77), 0,
                  UIDefine.getScreenWidth(2.77), 0),
              child: Text(
                _getTabTitle(dataList[i].name),
                style: TextStyle(
                    color: _getButtonColor(isCurrent),
                    fontSize: _getTextSize(isCurrent),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
        height: UIDefine.getScreenWidth(13),
        child: ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal,
            itemScrollController: controller,
            itemCount: buttons.length,
            itemBuilder: (context, index) {
              return buttons[index];
            }));
  }

  String _getTabTitle(String value) {
    switch (value) {
      case '':
        return tr('TopPicks');
      case 'polygonNFT':
        return tr('polygonNFT');
      case 'artwork':
        return tr('art');
      case 'collection':
        return tr('collectibles');
      // case 'bscNFT':
      //   return tr('bSCNFT');
      // case 'domain':
      //   return tr('domainNames');
      // case 'ercNFT':
      //   return tr('eRCNFT');
      // case 'facility':
      //   return tr('utility');
      // case 'music':
      //   return tr('music');
      // case 'photo':
      //   return tr('photography');
      // case 'sport':
      //   return tr('sports');
      // case 'tradeCard':
      //   return tr('tradingCards');
    }
    return '';
  }

  Color _getButtonColor(bool isCurrent) {
    if (isCurrent) return Colors.black;
    return Colors.grey;
  }

  double _getTextSize(bool isCurrent) {
    if (isCurrent) return UIDefine.fontSize20;
    return UIDefine.fontSize14;
  }

  Widget _buildListView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index % 2 == 0 && index == getItemCount() - 1) {
          return Padding(
              padding: EdgeInsets.fromLTRB(
                  UIDefine.getScreenWidth(5), 0, 0, UIDefine.getScreenWidth(0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  createItemBuilder(context, index),
                ],
              ));
        }
        if (index % 2 != 0) {
          return Container();
        }
        return Padding(
          padding: EdgeInsets.fromLTRB(UIDefine.getScreenWidth(5), 0,
              UIDefine.getScreenWidth(5), UIDefine.getScreenWidth(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createItemBuilder(context, index),
              createItemBuilder(context, index + 1)
            ],
          ),
        );
      },
      itemCount: getItemCount(),
      separatorBuilder: (BuildContext context, int index) {
        return createSeparatorBuilder(context, index);
      },
    );
  }

  Widget createItemBuilder(BuildContext context, int index) {
    return getExploreListViewItem(viewModel.discoverList[index], index);
  }

  Widget createSeparatorBuilder(BuildContext context, int index) {
    return SizedBox(height: UIDefine.getScreenWidth(1));
  }

  int getItemCount() {
    return viewModel.discoverList.length;
  }

  Widget getExploreListViewItem(DiscoverCollectData data, int index) {
    return Text(data.name);
  }
}
