import 'package:flutter/material.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../constant/ui_define.dart';
import '../../view_models/explore/explore_main_view_model.dart';
import 'data/explore_catogory_response_data.dart';

class ExploreMainView extends StatefulWidget {
  const ExploreMainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExploreMainView();

}

class _ExploreMainView extends State<ExploreMainView> {

  ExploreMainViewModel viewModel = ExploreMainViewModel();
  String currentExploreType = ''; // All類別打電文是帶空值
  ScrollController listController = ScrollController();
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];
  List<ExploreCategoryResponseData> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const DomainBar(),
        Container(
            padding: EdgeInsets.only(top: UIDefine.getScreenWidth(0.97), bottom: UIDefine.getScreenWidth(0.97)),
            margin: EdgeInsets.only(left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5), bottom: UIDefine.getScreenWidth(4.16)),
            child: viewModel.getExploreTypeButtons(
                controller: listController,
                dataList: dataList,
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

  _setData(List<ExploreCategoryResponseData> value) {
    dataList = value;
    ExploreCategoryResponseData data = ExploreCategoryResponseData();
    data.frontName = 'All';
    data.name = '';
    dataList.insert(0, data);
  }

  _setPage() {
    pages = List<Widget>.generate(dataList.length,
            (index) => viewModel.getExploreTypePage(dataList[index].name));
  }

  changePage(String exploreType) {
    setState(() {
      currentExploreType = exploreType;
      pageController.jumpToPage(getExploreTypeIndex(currentExploreType));
    });
  }

  void _onPageChange(int value) {
    setState(() {
      currentExploreType = dataList[value].name;
      // listController.jumpTo(value * 25);
    });
  }

  int getExploreTypeIndex(String type) {
    for (int i = 0; i < dataList.length; i++) {
      if (type == dataList[i].name) {
        return i;
      }
    }
    return -1;
  }

}
