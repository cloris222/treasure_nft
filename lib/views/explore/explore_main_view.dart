import 'package:flutter/material.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../view_models/explore/explore_main_view_model.dart';
import 'explore_type.dart';

class ExploreMainView extends StatefulWidget {
  const ExploreMainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExploreMainView();

}

class _ExploreMainView extends State<ExploreMainView> {

  ExploreMainViewModel viewModel = ExploreMainViewModel();
  ExploreType currentExploreType = ExploreType.All;
  ScrollController listController = ScrollController();
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(top: UIDefine.getScreenWidth(0.97), bottom: UIDefine.getScreenWidth(0.97)),
            margin: EdgeInsets.only(left: UIDefine.getScreenWidth(8.33), right: UIDefine.getScreenWidth(8.33), bottom: UIDefine.getScreenWidth(4.16)),
            height: UIDefine.getScreenWidth(11.11),
            child: viewModel.getExploreTypeButtons(
                controller: listController,
                currentExploreType: currentExploreType,
                changePage: (ExploreType exploreType) {
                  changePage(exploreType);
                })),
        Container(
          height: 2.5,
          color: AppColors.textRed,
        ),
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
    pages = List<Widget>.generate(viewModel.getExploreTypes().length,
            (index) => viewModel.getExploreTypePage(viewModel.getExploreTypes()[index]));
  }

  changePage(ExploreType exploreType) {
    setState(() {
      currentExploreType = exploreType;
      pageController.jumpToPage(getExploreTypeIndex(currentExploreType));
    });
  }

  void _onPageChange(int value) {
    setState(() {
      currentExploreType = ExploreType.values[value];
      // listController.jumpTo(value * 25);
    });
  }

  int getExploreTypeIndex(ExploreType type) {
    for (int i = 0; i < getExploreTypes().length; i++) {
      if (type == getExploreTypes()[i]) {
        return i;
      }
    }
    return -1;
  }

  List<ExploreType> getExploreTypes() {
    return <ExploreType>[ExploreType.All, ExploreType.ERC_NFT, ExploreType.Polygon_NFT, ExploreType.BSC_NFT];
  }

}
