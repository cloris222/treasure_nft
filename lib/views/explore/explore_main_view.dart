import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../constant/ui_define.dart';
import '../../view_models/explore/explore_main_view_model.dart';
import '../../view_models/home/provider/home_discover_provider.dart';
import '../../widgets/list_view/explore/get_explore_main_list_view.dart';
import 'data/explore_category_response_data.dart';

class ExploreMainView extends ConsumerStatefulWidget {
  const ExploreMainView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ExploreMainViewState();
}

class _ExploreMainViewState extends ConsumerState<ExploreMainView> {
  ExploreMainViewModel viewModel = ExploreMainViewModel();

  ItemScrollController listController = ItemScrollController();
  PageController pageController = PageController();

  List<ExploreCategoryResponseData> get dataListToShow {
    return ref.read(homeDisCoverTagsProvider);
  }

  List<Widget> pages = [];

// All類別打電文是帶空值
  String currentExploreType = '';

  @override
  void initState() {
    super.initState();
    ref.read(homeDisCoverTagsProvider.notifier).init(onFinish: () {
      if (dataListToShow.isNotEmpty) {
        setState(() {
          pages = List<Widget>.generate(dataListToShow.length,
              (index) => GetExploreMainListView(type: dataListToShow[index]));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // const DomainBar(),
        Container(
            padding: EdgeInsets.only(
                top: UIDefine.getScreenWidth(0.97),
                bottom: UIDefine.getScreenWidth(0.97)),
            margin: EdgeInsets.only(
                left: UIDefine.getScreenWidth(5),
                right: UIDefine.getScreenWidth(5),
                bottom: UIDefine.getScreenWidth(4.16)),
            child: viewModel.getExploreTypeButtons(
                controller: listController,
                dataList: dataListToShow,
                currentExploreType: currentExploreType,
                changePage: (ExploreCategoryResponseData exploreType) {
                  changePage(exploreType);
                })),
        Expanded(
          child: pages.isNotEmpty
              ? PageView(
                  controller: pageController,
                  onPageChanged: _onPageChange,
                  children: pages)
              : SizedBox(),
        )
      ]),
    );
  }

  void changePage(ExploreCategoryResponseData exploreType) {
    setState(() {
      currentExploreType = exploreType.name;
      pageController.jumpToPage(getExploreTypeIndex(currentExploreType));
    });
  }

  void _onPageChange(int value) {
    setState(() {
      currentExploreType = dataListToShow[value].name;
      if (value != 0) {
        listController.scrollTo(
            index: value - 1, duration: const Duration(milliseconds: 300));
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
