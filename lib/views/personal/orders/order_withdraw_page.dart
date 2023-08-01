import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/models/http/api/wallet_api.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/orders/withdraw/order_withdraw_type_page.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../constant/ui_define.dart';
import '../../../models/http/parameter/withdraw_alert_info.dart';
import '../../../utils/timer_util.dart';
import '../../../view_models/base_view_model.dart';
import '../../../view_models/gobal_provider/user_info_provider.dart';
import '../../../view_models/gobal_provider/user_property_info_provider.dart';
import '../../../view_models/wallet/wallet_withdraw_inter_payment_provider.dart';
import '../../../view_models/wallet/wallet_withdraw_payment_provider.dart';
import '../../../widgets/dialog/common_custom_dialog.dart';
import '../../../widgets/dialog/img_title_dialog.dart';
import '../common/google_auth/google_authenticator_page.dart';
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

  /// 是否能夠內部轉帳
  bool get canInternal {
    return ref.read(walletWithdrawInterPaymentProvider).isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    // _setPage();
    ///MARK: 檢查是否驗證google
    if (!ref.read(userInfoProvider).bindGoogle) {
      showGoogleUnVerify();
    }

    ref.read(walletWithdrawPaymentProvider.notifier).init();
    ref.read(walletWithdrawInterPaymentProvider.notifier).init();

    WalletAPI().checkWithdrawAlert().then((value) {
      withdrawAlertInfo = value;
      withdrawAlertInfo.isReserve = true;
      if (withdrawAlertInfo.isReserve) {
        ImgTitleDialog(context,
            img: AppImagePath.orderNoticeImg,
            singleBottom: true,
            onRightPress: () => Navigator.pop(context),
            mainText: tr("withdrawalErrorTitle"),
            subText: tr("withdrawalErrorText")).show();
      } else if (withdrawAlertInfo.isBlock) {
        CommonCustomDialog(context,
            title: tr("applicationFailed"),
            content: format(tr("resetUnlockText"),
                {"time": getBlockTimeFormat(value.expireIn.toInt())}),
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
    ref.watch(currentWithdrawPaymentProvider);
    ref.watch(walletWithdrawPaymentProvider);
    ref.watch(walletWithdrawInterPaymentProvider);

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
                    canInternal: canInternal,
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
            physics: canInternal ? null : const NeverScrollableScrollPhysics(),
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
    int index = _getExploreTypeIndex(exploreType);

    /// 關閉內部轉帳
    if (index == 1 && !canInternal) {
      return;
    }

    setState(() {
      currentExploreType = exploreType;
      pageController.jumpToPage(index);
    });
  }

  void _onPageChange(int index) {
    setState(() {
      currentExploreType = dataList[index];
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
    CommonCustomDialog(context,
            type: DialogImageType.fail,
            title: "",
            content: tr("googleVerificationError"),
            rightBtnText: tr('confirm'),
            onLeftPress: () {},
            onRightPress: () =>
                BaseViewModel().pushPage(context, const GoogleSettingPage()))
        .show();
  }

  /// 現在時間加上禁止秒數 再轉為(GMT+)HH:mm:ss
  String getBlockTimeFormat(int second) {
    DateTime now = DateTime.now();
    DateTime result = now.add(Duration(seconds: second));

    String forLocalDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(result);
    DateFormat inputFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    DateFormat outputFormat = DateFormat("HH:mm:ss");

    DateTime inputDateTime = inputFormat.parse(
        BaseViewModel().changeTimeZone(forLocalDateTime).toString());

    String formattedDateTime =
        "(${GlobalData.userZone})${outputFormat.format(inputDateTime)}";

    return formattedDateTime;
  }
}
