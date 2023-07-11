import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/models/http/api/trade_api.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_info_provider.dart';

import '../../models/http/parameter/check_level_info.dart';

class TradeNewMainViewModel extends BaseViewModel {
  TradeNewMainViewModel(this.ref,{required this.reservationSuccess, required this.errorMsgDialog});

  final onClickFunction reservationSuccess;
  final void Function(String mainText, String subText) errorMsgDialog;
  final WidgetRef ref;

  Future<void> addNewReservation({
    required int reserveIndex,
    required num reserveStartPrice,
    required num reserveEndPrice,
  }) async {
    /// 確認體驗帳號狀態
    await TradeAPI(onConnectFail: _experienceExpired, showTrString: false).getExperienceInfoAPI().then((value) {
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
        priceIndex: reserveIndex);

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
    errorMsgDialog(tr("reserve-failed'"), '');
  }

  void _onAddReservationFail(String errorMessage) {
    switch (errorMessage) {
      /// 預約金不足
      case 'APP_0064':
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0064'));
        break;

      /// 餘額不足
      case 'APP_0013':
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0013'));
        break;

      /// 預約金額不符
      case 'APP_0041':
        errorMsgDialog(tr("reserve-failed'"), tr('APP_0041'));
        break;

      /// 新手帳號交易天數到期
      case 'APP_0069':
        errorMsgDialog(tr("expEnd_title"), format(tr('expEnd_title_hint'), {'amount': ref.watch(beginAmount.notifier).state}));
        break;
      default:
        errorMsgDialog(tr("reserve-failed'"), tr(errorMessage));
        break;
    }
  }
}
