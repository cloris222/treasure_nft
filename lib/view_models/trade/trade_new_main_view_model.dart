import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/control_router_viem_model.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/global_isloading_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_info_provider.dart';

import '../../models/http/parameter/check_level_info.dart';
import '../../views/trade/reserve_loading_page.dart';

class TradeNewMainViewModel extends BaseViewModel {
  TradeNewMainViewModel(this.ref,{required this.reservationSuccess, required this.errorMsgDialog});

  final onClickFunction reservationSuccess;
  final void Function(String mainText, String subText) errorMsgDialog;
  final WidgetRef ref;

  Future<void> addNewReservation(BuildContext context,{
    required int reserveIndex,
    required num reserveStartPrice,
    required num reserveEndPrice,
    required num startExpectedReturn,
    required num endExpectedReturn
  }) async {
    // showLoadingPage(context);
    /// 確認體驗帳號狀態
    await TradeAPI(onConnectFail: _experienceExpired, showTrString: true).getExperienceInfoAPI().then((value) {
      if (value.isExperience == true && value.status == 'EXPIRED') {
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0057'));
      } else if (value.isExperience == true && value.status == 'DISABLE') {
        errorMsgDialog(tr("reserve-failed'"), '');
      }
    });

    /// 新增預約
    await TradeAPI(onConnectFail: _onAddReservationFail, showTrString: false).postAddNewReservationAPI(
      type: "PRICE",
      reserveCount: 1,
      startPrice: reserveEndPrice,
      endPrice: reserveStartPrice,
      priceIndex: reserveIndex).then((value) {
          ref.read(globalIsLoadingProvider.notifier).update((state) => true);
          ControlRouterViewModel().pushOpacityPage(context,  ReserveLoadingPage(
            ref: ref,
            startExpectedReturn: startExpectedReturn,
            endExpectedReturn: endExpectedReturn,
          ));
      });

    // closeLoadingPage();
    /// 如果預約成功 會進call back function
    reservationSuccess();
  }

  /// display star ~ end price range
  String getRange(CheckLevelInfo? userLevelInfo) {
    dynamic min;
    dynamic max;

    min = userLevelInfo?.buyRangeStart;
    max = userLevelInfo?.buyRangeEnd;
    return '$min~$max';
  }

  void _experienceExpired(String errorMessage) {
    // closeLoadingPage();
    errorMsgDialog(tr("reserve-failed'"), '');
  }

  void _onAddReservationFail(String errorMessage) {
    // closeLoadingPage();
    switch (errorMessage) {
      /// 預約金不足
      case 'APP_0064':
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0064'));
        break;

      /// 餘額不足
      case 'APP_0013':
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0013')
        );
        break;

      /// 預約金額不符
      case 'APP_0041':
        errorMsgDialog(tr("reserve-failed'"),
            tr('APP_0041')
        );
        break;

      /// 新手帳號交易天數到期
      case 'APP_0069':
        errorMsgDialog(tr("expEnd_title"), format(tr('expEnd_title_hint'), {'amount': ref.watch(beginAmount.notifier).state}));
        break;

      /// 預約次數已達上限
      case 'APP_0043':
        errorMsgDialog(tr("reserve-failed'"), tr("reserve-APP_0043'"));
        break;

      default:
        errorMsgDialog(tr("reserve-failed'"), tr(errorMessage));
        break;
    }
  }
}
