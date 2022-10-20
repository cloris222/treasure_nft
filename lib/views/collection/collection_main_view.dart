import 'package:flutter/material.dart';

import '../../constant/ui_define.dart';
import '../../view_models/collection/collection_main_view_model.dart';
import '../../widgets/domain_bar.dart';

class CollectionMainView extends StatefulWidget {
  const CollectionMainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CollectionMainView();

}

class _CollectionMainView extends State<CollectionMainView> {

  CollectionMainViewModel viewModel = CollectionMainViewModel();
  String currentExploreType = 'Reservation';
  ScrollController listController = ScrollController();
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];
  List<String> dataList = ['Reservation', 'Selling', 'Pending'];

  @override
  void initState() {
    super.initState();
    _setPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const DomainBar(),
        Container(
            padding: EdgeInsets.only(top: UIDefine.getScreenWidth(0.97), bottom: UIDefine.getScreenWidth(0.97)),
            margin: EdgeInsets.only(left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5), bottom: UIDefine.getScreenWidth(4.16)),
            child: viewModel.getCollectionTypeButtons(
                controller: listController,
                dataList: dataList,
                currentExploreType: currentExploreType,
                changePage: (String exploreType) {
                  _changePage(exploreType);
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

  void _setPage() {
    pages = List<Widget>.generate(dataList.length,
            (index) => viewModel.getCollectionTypePage(dataList[index]));
  }

  void _changePage(String exploreType) {
    setState(() {
      currentExploreType = exploreType;
      pageController.jumpToPage(_getExploreTypeIndex(currentExploreType));
    });
  }

  void _onPageChange(int value) {
    setState(() {
      currentExploreType = dataList[value];
      // listController.jumpTo(value * 25);
    });
  }

  int _getExploreTypeIndex(String type) {
    for (int i = 0; i < dataList.length; i++) {
      if (type == dataList[i]) {
        return i;
      }
    }
    return -1;
  }

}
