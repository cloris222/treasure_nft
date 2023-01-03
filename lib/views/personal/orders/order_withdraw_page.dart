import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/views/personal/orders/withdraw/order_withdraw_type_page.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';

import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/withdraw_alert_info.dart';
import '../../../widgets/dialog/common_custom_dialog.dart';
import 'withdraw/order_withdraw_tab_bar.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';

///MARK: 提領
class OrderWithdrawPage extends StatefulWidget {
  const OrderWithdrawPage(
      {Key? key, this.type = AppNavigationBarType.typeWallet})
      : super(key: key);
  final AppNavigationBarType type;

  @override
  State<StatefulWidget> createState() => _OrderWithdrawPage();
}

class _OrderWithdrawPage extends State<OrderWithdrawPage> {
  String currentExploreType = 'Chain';
  PageController pageController = PageController();
  List<Widget> pages = <Widget>[];
  List<String> dataList = ['Chain', 'Internal'];
  WithdrawAlertInfo withdrawAlertInfo = WithdrawAlertInfo();

  @override
  void initState() {
    super.initState();
    _setPage();
    WalletAPI().checkWithdrawAlert().then((value) {
      withdrawAlertInfo = value;
      if (withdrawAlertInfo.isReserve) {
        CommonCustomDialog(context,
            title: tr("reservenotDrawn"),
            content: tr('reservenotDrawn-hint'),
            type: DialogImageType.fail,
            rightBtnText: tr('confirm'),
            onLeftPress: () {}, onRightPress: () {
          Navigator.pop(context);
        }).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
              child: TitleAppBar(
                  title: tr('walletWithdraw'), needArrowIcon: false)),
          Container(
            padding: EdgeInsets.only(
                top: UIDefine.getScreenWidth(0.97),
                bottom: UIDefine.getScreenWidth(0.97)),
            margin: EdgeInsets.only(
                left: UIDefine.getScreenWidth(5),
                right: UIDefine.getScreenWidth(5)),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: OrderWithdrawTabBar().getCollectionTypeButtons(
                    dataList: dataList,
                    currentExploreType: currentExploreType,
                    changePage: (String exploreType) {
                      _changePage(exploreType);
                    })),
          ),
          SizedBox(height: UIDefine.getPixelWidth(10)),
          Expanded(
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
    pages = List<Widget>.generate(
        dataList.length,
        (index) => OrderWithdrawTypePage(
            currentType: dataList[index],
            getWalletAlert: () => withdrawAlertInfo));
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
