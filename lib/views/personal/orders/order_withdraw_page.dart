import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/orders/withdraw/order_withdraw_type_page.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/withdraw_alert_info.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/gobal_provider/user_info_provider.dart';
import '../../../view_models/gobal_provider/user_property_info_provider.dart';
import '../../../widgets/dialog/common_custom_dialog.dart';
import '../common/google_authenticator_page.dart';
import 'withdraw/order_withdraw_tab_bar.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';

///MARK: 提領
class OrderWithdrawPage extends ConsumerStatefulWidget {
  const OrderWithdrawPage(
      {Key? key, this.type = AppNavigationBarType.typeWallet})
      : super(key: key);
  final AppNavigationBarType type;

  @override
  ConsumerState createState() => _OrderWithdrawPageState();
}

class _OrderWithdrawPageState extends ConsumerState<OrderWithdrawPage> {
  String currentExploreType = 'Chain';
  PageController pageController = PageController();

  // List<Widget> pages = <Widget>[];
  List<String> dataList = ['Chain', 'Internal'];
  WithdrawAlertInfo withdrawAlertInfo = WithdrawAlertInfo();

  num get experienceMoney {
    return ref.read(userPropertyInfoProvider)?.getExperienceMoney() ?? 0;
  }

  @override
  void initState() {
    super.initState();
    // _setPage();
    ///MARK: 檢查是否驗證google
    if (!ref.read(userInfoProvider).bindGoogle) {
      showGoogleUnVerify();
    }

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
    ///監聽用
    ref.watch(userPropertyInfoProvider);

    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: widget.type,
      body: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
              child: TitleAppBar(
                  title: tr('walletWithdraw'), needCloseIcon: false)),
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
            children: List<Widget>.generate(
                dataList.length,
                (index) => OrderWithdrawTypePage(
                    experienceMoney: experienceMoney,
                    currentType: dataList[index],
                    getWalletAlert: () => withdrawAlertInfo)),
          ))
        ],
      ),
    );
  }
  // void _setPage() {
  //   pages = List<Widget>.generate(
  //       dataList.length,
  //       (index) => OrderWithdrawTypePage(
  //           currentType: dataList[index],
  //           getWalletAlert: () => withdrawAlertInfo));
  // }

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

  void showGoogleUnVerify() {
    CommonCustomDialog(
        context,
        type: DialogImageType.fail,
        title: "",
        content: tr('googleVerificationError'),
        rightBtnText: tr('confirm'),
        onLeftPress: () {},
        onRightPress: () =>
            BaseViewModel().pushPage(context, const GoogleSettingPage())
    ).show();
  }
}
