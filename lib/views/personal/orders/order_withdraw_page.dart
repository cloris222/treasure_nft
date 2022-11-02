import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/personal/orders/withdraw/order_withdraw_type_page.dart';

import '../../../constant/ui_define.dart';
import '../../custom_appbar_view.dart';
import 'withdraw/order_withdraw_tab_bar.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';

///MARK: 提領
class OrderWithdrawPage extends StatefulWidget {
  const OrderWithdrawPage(
      {Key? key, this.type = AppNavigationBarType.typeWallet}) : super(key: key);
  final AppNavigationBarType type;

  @override
  State<StatefulWidget> createState() => _OrderWithdrawPage();
}


class _OrderWithdrawPage extends State<OrderWithdrawPage> {

  String currentExploreType = 'Chain';
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];
  List<String> dataList = ['Chain', 'Internal'];

  @override
  void initState() {
    super.initState();
    _setPage();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      title: tr("walletWithdraw"),
      type: widget.type,
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: UIDefine.getScreenWidth(0.97), bottom: UIDefine.getScreenWidth(0.97)),
              margin: EdgeInsets.only(left: UIDefine.getScreenWidth(5), right: UIDefine.getScreenWidth(5), bottom: UIDefine.getScreenWidth(4.16)),
              child: OrderWithdrawTabBar().getCollectionTypeButtons(
                  dataList: dataList,
                  currentExploreType: currentExploreType,
                  changePage: (String exploreType) {
                    _changePage(exploreType);
                  })),

          SizedBox(height: UIDefine.getScreenWidth(2.77)),
          Flexible(
              child: PageView(
                controller: pageController,
                onPageChanged: _onPageChange,
                children: pages,
              ))
        ],
      ),

   );
  }

  void _setPage() {
    pages = List<Widget>.generate(dataList.length,
            (index) => OrderWithdrawTypePage(currentType: dataList[index]));
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
