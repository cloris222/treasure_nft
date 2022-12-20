import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../constant/ui_define.dart';
import '../../view_models/explore/explore_main_view_model.dart';
import 'data/explore_category_response_data.dart';

class ExploreMainView extends StatefulWidget {
  const ExploreMainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExploreMainView();

}

class _ExploreMainView extends State<ExploreMainView> {

  ExploreMainViewModel viewModel = ExploreMainViewModel();
  String currentExploreType = ''; // All類別打電文是帶空值
  ItemScrollController listController = ItemScrollController();
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];
  List<ExploreCategoryResponseData> dataListToShow = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // const DomainBar(),
        Container(
            padding: EdgeInsets.only(top: UIDefine.getScreenWidth(0.97), bottom: UIDefine.getScreenWidth(0.97)),
            margin: EdgeInsets.only(left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5), bottom: UIDefine.getScreenWidth(4.16)),
            child: viewModel.getExploreTypeButtons(
                controller: listController,
                dataList: dataListToShow,
                currentExploreType: currentExploreType,
                changePage: (String exploreType) {
                  changePage(exploreType);
                })),
        Flexible(
            child: PageView(
              controller: pageController,
              onPageChanged: _onPageChange,
              children: pages,
            ))
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    Future<List<ExploreCategoryResponseData>> list = viewModel.getExploreCategory();
    list.then((value) => {setState(() {}), _setData(value), _setPage() });
  }

  void _setData(List<ExploreCategoryResponseData> value) {
    List<ExploreCategoryResponseData> respList = value;
    for (int i = 0; i < respList.length; i++) {
      if (respList[i].name == 'polygonNFT') {
        dataListToShow.insert(0, respList[i]);
      }
      if (respList[i].name == 'artwork') {
        dataListToShow.add(respList[i]);
      }
      if (respList[i].name == 'collection') {
        dataListToShow.add(respList[i]);
      }
    }
    ExploreCategoryResponseData data = ExploreCategoryResponseData();
    data.frontName = 'All';
    data.name = '';
    dataListToShow.insert(0, data);
  }

  void _setPage() {
    pages = List<Widget>.generate(dataListToShow.length,
            (index) => viewModel.getExploreTypePage(dataListToShow[index].name));
  }

  void changePage(String exploreType) {
    setState(() {
      currentExploreType = exploreType;
      pageController.jumpToPage(getExploreTypeIndex(currentExploreType));
    });
  }

  void _onPageChange(int value) {
    setState(() {
      currentExploreType = dataListToShow[value].name;
      if (value != 0) {
        listController.scrollTo(index: value - 1, duration: const Duration(milliseconds: 300));
      }
    });
  }

  int getExploreTypeIndex(String type) {
    for (int i = 0; i < dataListToShow.length; i++) {
      if (type == dataListToShow[i].name) {
        return i;
      }
    }
    return -1;
  }

}
