// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:treasure_nft_project/constant/global_data.dart';
// import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
// import 'package:treasure_nft_project/constant/theme/app_colors.dart';
// import 'package:treasure_nft_project/constant/theme/app_style.dart';
// import 'package:treasure_nft_project/constant/ui_define.dart';
// import 'package:treasure_nft_project/models/data/trade_model_data.dart';
// import 'package:treasure_nft_project/models/http/parameter/check_reserve_deposit.dart';
// import 'package:treasure_nft_project/utils/number_format_util.dart';
// import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
// import 'package:treasure_nft_project/widgets/dialog/animation_dialog.dart';
// import 'package:treasure_nft_project/widgets/dialog/success_dialog.dart';
// import 'package:treasure_nft_project/widgets/trade_countdown_view.dart';
// import 'package:treasure_nft_project/utils/app_text_style.dart';
// import '../../models/http/api/trade_api.dart';
// import '../../utils/trade_timer_util.dart';
// import '../../view_models/trade/trade_division_viewmodel.dart';
// import '../../widgets/dialog/common_custom_dialog.dart';
// import '../../widgets/dialog/new_reservation_dialog.dart';
// import '../../widgets/dialog/simple_custom_dialog.dart';
// import '../../widgets/label/level_detail.dart';
// import '../../widgets/list_view/trade/level_area_division_cell.dart';
// import '../custom_appbar_view.dart';
// import '../personal/orders/order_withdraw_page.dart';
//
// ///MARK: 第二層 副本入口
// class TradeDivisionView extends StatefulWidget {
//   const TradeDivisionView({
//     Key? key,
//     required this.level,
//   }) : super(key: key);
//
//   final int level;
//
//   @override
//   State<TradeDivisionView> createState() => _TradeDivisionViewState();
// }
//
// class _TradeDivisionViewState extends State<TradeDivisionView> {
//   late TradeDivisionViewModel viewModel;
//
//   @override
//   void initState() {
//     viewModel = TradeDivisionViewModel(
//       widget.level,
//       setState: () {
//         if (mounted) {
//           setState(() {});
//         }
//       },
//
//       /// 預約成功
//       reservationSuccess: () {
//         AnimationDialog(context, AppAnimationPath.reserveSuccess).show();
//       },
//
//       /// 預約金不足
//       bookPriceNotEnough: () {
//         SuccessDialog(context,
//                 callOkFunction: () {},
//                 isSuccess: false,
//                 mainText: tr("reserve-failed'"))
//             .show();
//       },
//
//       /// 餘額不足
//       notEnoughToPay: () {
//         SuccessDialog(context,
//                 callOkFunction: () {},
//                 isSuccess: false,
//                 mainText: tr("reserve-failed'"),
//                 subText: tr('APP_0013'))
//             .show();
//       },
//
//       /// 預約金額不符
//       depositNotEnough: () {
//         SuccessDialog(context,
//                 callOkFunction: () {},
//                 isSuccess: false,
//                 mainText: tr("reserve-failed'"),
//                 subText: tr('APP_0041'))
//             .show();
//       },
//       errorMes: (errorCode) {
//         SimpleCustomDialog(context, mainText: tr(errorCode), isSuccess: false)
//             .show();
//       },
//
//       /// 體驗帳號狀態過期
//       experienceExpired: () {
//         CommonCustomDialog(context,
//             type: DialogImageType.warning,
//             title: tr('exp_finish_title'),
//             content:
//                 '${tr('exp_finish_content_1')}\n${tr('exp_finish_content_2')}',
//             rightBtnText: tr('gotoExtract'),
//             onLeftPress: () {}, onRightPress: () {
//           Navigator.pop(context);
//           viewModel.pushPage(context, const OrderWithdrawPage());
//         }).show();
//       },
//
//       /// 體驗帳號狀態關閉
//       experienceDisable: () {
//         SuccessDialog(
//           context,
//           callOkFunction: () {},
//           isSuccess: false,
//           mainText: tr("reserve-failed'"),
//         ).show();
//       },
//
//       /// 新手帳號交易天數到期
//       beginnerExpired: () {
//         SuccessDialog(context,
//                 callOkFunction: () {},
//                 isSuccess: false,
//                 mainText: tr("reserve-failed'"),
//                 subText: tr('APP_0069'))
//             .show();
//       },
//     );
//
//     viewModel.initState();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     viewModel.disposeState();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     /// 將開賣狀態的值往下傳
//     TradeData tradeData = viewModel.currentData;
//     return CustomAppbarView(
//         needCover: true,
//         needScrollView: true,
//         onLanguageChange: () {
//           if (mounted) {
//             setState(() {});
//           }
//         },
//         body: Column(children: [
//           TitleAppBar(title: widget.level == 0
//               ? tr('noviceArea')
//               : '${tr("level")} ${widget.level}'),
//           const SizedBox(
//             height: 5,
//           ),
//           TradeCountDownView(tradeData: viewModel.currentData),
//           _levelView(context),
//           checkDataInit(tradeData),
//           SizedBox(height: UIDefine.navigationBarPadding)
//         ]));
//   }
//
//   Widget _levelView(BuildContext context) {
//     TextStyle titleStyle = AppTextStyle.getBaseStyle(fontSize: UIDefine.fontSize16);
//     double balance = TradeTimerUtil().getReservationInfo()?.balance ?? 0;
//     double reserveBalance =
//         TradeTimerUtil().getReservationInfo()?.reserveBalance ?? 0;
//     if (reserveBalance < 0) {
//       reserveBalance = 0;
//     }
//
//     return Container(
//         margin: EdgeInsets.symmetric(
//             vertical: 10, horizontal: UIDefine.getWidth() / 30),
//         child: Column(children: [
//           Row(children: [
//             Image.asset(
//               viewModel.getLevelImg(),
//               width: UIDefine.getWidth() / 11,
//               height: UIDefine.getWidth() / 11,
//             ),
//             const SizedBox(width: 10),
//             Text(tr('level'), style: titleStyle),
//             const SizedBox(width: 5),
//             Text('${GlobalData.userInfo.level}', style: titleStyle)
//           ]),
//           const SizedBox(height: 10),
//           Container(
//               decoration: AppStyle().styleColorBorderBackground(
//                   color: AppColors.bolderGrey, borderLine: 2),
//               padding: const EdgeInsets.all(10),
//               child: Column(children: [
//                 Column(children: [
//                   LevelDetailLabel(
//                       title: tr("wallet-balance'"),
//                       showCoins: false,
//                       content: NumberFormatUtil().removeTwoPointFormat(balance),
//                       rightFontWeight: FontWeight.w500),
//                   LevelDetailLabel(
//                       title: tr("availableBalance"),
//                       content: NumberFormatUtil()
//                           .removeTwoPointFormat(reserveBalance),
//                       rightFontWeight: FontWeight.w500),
//                   LevelDetailLabel(
//                       title: tr('amountRangeNFT'),
//                       showCoins: false,
//                       content: viewModel.getRange(),
//                       rightFontWeight: FontWeight.w500)
//                 ])
//               ]))
//         ]));
//   }
//
//   Widget checkDataInit(TradeData tradeData) {
//     return _levelArea(context, tradeData);
//   }
//
//   Widget _levelArea(BuildContext context, TradeData tradeData) {
//     return ListView.builder(
//         itemCount: viewModel.ranges.length,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return DivisionCell(
//             /// press btn check reservation info
//             reservationAction: () async {
//               /// 查詢預約金
//               CheckReserveDeposit checkReserveDeposit;
//               checkReserveDeposit = await TradeAPI().getCheckReserveDepositAPI(
//                   viewModel.ranges[index].index,
//                   viewModel.ranges[index].startPrice.toDouble(),
//                   viewModel.ranges[index].endPrice.toDouble());
//
//               /// 推透明頁面！！！
//               Navigator.of(context).push(PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) {
//                     return NewReservationPopUpView(
//                       confirmBtnAction: () async {
//                         Navigator.pop(context);
//
//                         /// add new reservation
//                         await viewModel.addNewReservation(index);
//                       },
//                       reservationFee: '${checkReserveDeposit.deposit}',
//                       transactionTime: '${checkReserveDeposit.tradingTime}',
//                       transactionReward: '${checkReserveDeposit.reward}',
//                     );
//                   },
//
//                   /// 透明頁一定要加
//                   opaque: false));
//             },
//             range: viewModel.ranges[index],
//             level: widget.level,
//             tradeData: tradeData,
//             imageIndex: index,
//           );
//         });
//   }
// }
