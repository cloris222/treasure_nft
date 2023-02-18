// import 'package:flutter/cupertino.dart';
// import 'package:format/format.dart';
// import 'package:treasure_nft_project/constant/global_data.dart';
// import 'package:treasure_nft_project/models/data/trade_model_data.dart';
// import 'package:treasure_nft_project/models/http/api/user_info_api.dart';
// import 'package:treasure_nft_project/models/http/parameter/check_reservation_info.dart';
// import 'package:treasure_nft_project/utils/trade_timer_util.dart';
// import 'package:treasure_nft_project/view_models/base_view_model.dart';
// import '../../constant/call_back_function.dart';
// import '../../constant/theme/app_image_path.dart';
// import '../../models/http/api/trade_api.dart';
//
// class TradeMainViewModel extends BaseViewModel {
//   TradeMainViewModel(
//       {required this.setState,
//       required this.reservationSuccess,
//       required this.bookPriceNotEnough,
//       required this.notEnoughToPay,
//       required this.depositNotEnough,
//       required this.errorMes,
//       required this.experienceExpired,
//       required this.beginnerExpired,
//       required this.experienceDisable});
//
//   final onClickFunction setState;
//   List<int> division = [];
//   List<ReserveRange> ranges = [];
//   VoidCallback notEnoughToPay;
//   VoidCallback bookPriceNotEnough;
//   VoidCallback reservationSuccess;
//   VoidCallback depositNotEnough;
//   VoidCallback beginnerExpired;
//   VoidCallback experienceExpired;
//   VoidCallback experienceDisable;
//   ResponseErrorFunction errorMes;
//
//   late TradeData currentData;
//
//   void initState() {
//     ///MARK: timer監聽
//     currentData = TradeTimerUtil().getCurrentTradeData();
//     setState();
//     TradeTimerUtil().addListener(_onUpdateTrade);
//
//     ///更新畫面
//     TradeAPI().getDivisionAPI().then((value) {
//       division = value;
//       setState();
//     });
//     TradeAPI().getCheckReservationInfoAPI(0).then((value) {
//       TradeTimerUtil().start(setInfo: value);
//       ranges = value.reserveRanges;
//
//       /// 如果是體驗帳號 且 level 1 副本顯示內容不同
//       if (GlobalData.experienceInfo.isExperience == true &&
//           GlobalData.userInfo.level == 1) {
//         ranges[0].startPrice = 1;
//         ranges[0].endPrice = 50;
//         ranges[1].startPrice = 50;
//         ranges[1].endPrice = 150;
//       }
//       setState();
//     });
//     UserInfoAPI().getCheckLevelInfoAPI().then((value) => setState());
//   }
//
//   /// 離開頁面後清除時間
//   void disposeState() {
//     TradeTimerUtil().removeListener(_onUpdateTrade);
//   }
//
//   addNewReservation(int index) async {
//     /// 確認體驗帳號狀態
//     await TradeAPI(onConnectFail: _experienceExpired, showTrString: false)
//         .getExperienceInfoAPI()
//         .then((value) {
//       if (value.isExperience == true && value.status == 'EXPIRED') {
//         experienceExpired();
//       } else if (value.isExperience == true && value.status == 'DISABLE') {
//         experienceDisable();
//       }
//     });
//
//     /// 新增預約
//     await TradeAPI(onConnectFail: _onAddReservationFail, showTrString: false)
//         .postAddNewReservationAPI(
//             type: "PRICE",
//             reserveCount: 1,
//             startPrice: ranges[index].startPrice,
//             endPrice: ranges[index].endPrice,
//             priceIndex: ranges[index].index);
//
//     /// 如果預約成功 會進call back function
//     reservationSuccess();
//   }
//
//   /// 體驗帳號狀態失效
//   void _experienceExpired(String errorMessage) {
//     experienceDisable();
//   }
//
//   /// 預約失敗顯示彈窗
//   void _onAddReservationFail(String errorMessage) {
//     switch (errorMessage) {
//
//       /// 預約金不足
//       case 'APP_0064':
//         bookPriceNotEnough();
//         break;
//
//       /// 餘額不足
//       case 'APP_0013':
//         notEnoughToPay();
//         break;
//
//       /// 預約金額不符
//       case 'APP_0041':
//         depositNotEnough();
//         break;
//
//       /// 新手帳號交易天數到期
//       case 'APP_0069':
//         beginnerExpired();
//         break;
//       default:
//         errorMes(errorMessage);
//         break;
//     }
//   }
//
//   /// display star ~ end price range
//   String getRange() {
//     dynamic min;
//     dynamic max;
//
//     min = GlobalData.userLevelInfo?.buyRangeStart;
//     max = GlobalData.userLevelInfo?.buyRangeEnd;
//     return '$min~$max';
//   }
//
//   /// display level image
//   String getLevelImg() {
//     return format(AppImagePath.level, ({'level': GlobalData.userInfo.level}));
//   }
//
//   void _onUpdateTrade(TradeData data) {
//     currentData = data;
//     setState();
//   }
// }
