import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../constant/ui_define.dart';
import '../../view_models/collection/collection_main_view_model.dart';
import '../../widgets/button/icon_text_button_widget.dart';
import '../../widgets/domain_bar.dart';
import 'deposit/deposit_nft_main_view.dart';

class CollectionMainView extends StatefulWidget {
  const CollectionMainView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CollectionMainView();
}

class _CollectionMainView extends State<CollectionMainView> {

  CollectionMainViewModel viewModel = CollectionMainViewModel();
  String currentExploreType = 'Reservation';
  ItemScrollController listController = ItemScrollController();
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];
  // bool _switchHostingValue = false;
  List<String> dataList = ['Reservation', 'Pending', 'Selling', 'Ticket'];

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
            margin: EdgeInsets.only(left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5), bottom: UIDefine.getScreenWidth(0.8)),
            child: viewModel.getCollectionTypeButtons(
                controller: listController,
                dataList: dataList,
                currentExploreType: currentExploreType,
                changePage: (String exploreType) {
                  _changePage(exploreType);
                })),
        // 如要置頂不滑動才放此Class
        // Visibility(
        //   visible: currentExploreType == 'Pending',
        //   child: _getDepositBtn()
        // ),
        // SizedBox(height: UIDefine.getScreenWidth(2)),
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
      if (value != 0) {
        listController.scrollTo(index: value - 1, duration: const Duration(milliseconds: 300));
      }
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

  // 如要置頂不滑動才放此Class
  Widget _getDepositBtn() {
    return IconTextButtonWidget(
      height: UIDefine.getScreenWidth(10),
      btnText: tr("depositNFT"),
      iconPath: 'assets/icon/btn/btn_card_01_nor.png',
      onPressed: () { viewModel.pushPage(context, DepositNftMainView()); }
    );
  }

}
