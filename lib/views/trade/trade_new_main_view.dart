import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/trade_enum.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_level_info_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_division_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_info_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_stage_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_volume_provider.dart';
import 'package:treasure_nft_project/view_models/trade/trade_new_main_view_model.dart';
import 'package:treasure_nft_project/views/trade/trade_main_level_view.dart';
import 'package:treasure_nft_project/views/trade/trade_main_user_info_view.dart';
import 'package:treasure_nft_project/widgets/dialog/success_dialog.dart';
import 'package:treasure_nft_project/widgets/dialog/trade_rule_dialot.dart';
import 'package:treasure_nft_project/widgets/label/icon/level_icon_widget.dart';

import '../../models/data/trade_model_data.dart';
import '../../models/http/parameter/check_reservation_info.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../utils/trade_timer_util.dart';
import '../../view_models/gobal_provider/user_info_provider.dart';
import '../../view_models/trade/provider/trade_reserve_coin_provider.dart';
import '../../view_models/trade/provider/trade_time_provider.dart';

class TradeNewMainView extends ConsumerStatefulWidget {
  const TradeNewMainView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TradeNewMainViewState();
}

class _TradeNewMainViewState extends ConsumerState<TradeNewMainView> {
  Color backgroundColor = const Color(0xFFF8F8F8);
  late TradeNewMainViewModel viewModel;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    viewModel = TradeNewMainViewModel(reservationSuccess: () {
      /// MARK: 預約成功通知
      // SuccessDialog(context,
      //         callOkFunction: () {},
      //         isSuccess: true,
      //         mainText: tr("reserve-success'"),
      //         subText: tr("reserve-success-text'"))
      //     .show();
    }, errorMsgDialog: (String mainText, String subText) {
      SuccessDialog(context, callOkFunction: () {}, isSuccess: false, mainText: mainText, subText: subText).show();
    }, ref);

    ///MARK: 初始化
    TradeTimerUtil().addListener(_onUpdateTrade);

    ///使用者資料&交易量
    Future.delayed(Duration.zero, () async {
      await ref.read(userLevelInfoProvider.notifier).init();
      ref.read(tradeReserveVolumeProvider.notifier).setDivisionIndex(0);
      await ref.read(tradeReserveVolumeProvider.notifier).init();
      await ref.read(tradeReserveDivisionProvider.notifier).init();
      if(ref.read(userInfoProvider).level == 0) {
        ref.read(tradeReserveInfoProvider.notifier).setCurrentChoose(0, null, null);
      }
      ref.read(tradeReserveInfoProvider.notifier).getBeginerHintNum().then((value) {
        if(!mounted)return;
        ref.read(beginAmount.notifier).update((state) => value.toString());
      });
      await ref.read(tradeReserveInfoProvider.notifier).init(onFinish: () {
        if(!mounted)return;
        if (ref.read(tradeReserveInfoProvider) != null) {
          if (ref.read(tradeReserveInfoProvider)!.reserveRanges.isNotEmpty) {
            ReserveRange range = ref.read(tradeReserveInfoProvider)!.reserveRanges[0];
            ref.read(tradeReserveCoinProvider.notifier).setSelectValue(range.index, range.startPrice, range.endPrice, range.rewardRate);
            ref.read(tradeReserveCoinProvider.notifier).init();
          }
        }
      });
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    TradeTimerUtil().removeListener(_onUpdateTrade);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoData userInfo = ref.watch(userInfoProvider);
    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            _buildTitle(userInfo),

            ///微小的彩虹色露出O_O
            Container(height: 1, width: UIDefine.getWidth(), color: backgroundColor),
            Container(
              width: UIDefine.getWidth(),
              padding: EdgeInsets.only(
                  left: UIDefine.getPixelWidth(15),
                  right: UIDefine.getPixelWidth(15),
                  bottom: UIDefine.navigationBarPadding),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ///MARK: 使用者錢包相關資訊
                TradeMainUserInfoView(viewModel: viewModel),
                SizedBox(height: UIDefine.getPixelWidth(10)),
                TradeMainLevelView(
                    viewModel: viewModel,
                    onScrollTop: () {
                      controller.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
                    }),
                // SizedBox(height: UIDefine.navigationBarPadding),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(UserInfoData userInfo) {
    return SizedBox(height: UIDefine.getPixelWidth(16),);
    // return Container(
    //   decoration: AppStyle().buildGradient(borderWith: 0, colors: AppColors.gradientBackgroundColorNoFloatBg),
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Container(
    //         padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(15), vertical: UIDefine.getPixelWidth(15)),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             LevelIconWidget(level: userInfo.level, needBig: true, size: UIDefine.getPixelWidth(40)),
    //             // Text(
    //             //   '${tr('level')} ${userInfo.level}',
    //             //   style: AppTextStyle.getBaseStyle(
    //             //       fontSize: UIDefine.fontSize14,
    //             //       fontWeight: FontWeight.w600),
    //             // ),
    //             const Spacer(),
    //             GestureDetector(
    //               onTap: () {
    //                 TradeRuleDialog(context).show();
    //               },
    //               child: Container(
    //                 color: Colors.transparent,
    //                 child: Text(
    //                   tr('trade-rules'),
    //                   style: AppTextStyle.getBaseStyle(
    //                       fontSize: UIDefine.fontSize14, fontWeight: FontWeight.w400, color: const Color(0xFF5CBFFE)),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Container(
    //         height: UIDefine.getPixelWidth(15),
    //         width: UIDefine.getWidth(),
    //         decoration: AppStyle()
    //             .styleColorsRadiusBackground(color: backgroundColor, hasBottomRight: false, hasBottomLef: false),
    //       )
    //     ],
    //   ),
    // );
  }

  bool waitReadAPI = false;

  void _onUpdateTrade(TradeData data) async {
    ref.read(tradeTimeProvider.notifier).updateTradeTime(data);
    if (!waitReadAPI) {
      waitReadAPI = true;

      ///MARK:預約結束 代表需更新狀態
      if (data.status == SellingState.End) {
        await ref.read(tradeReserveInfoProvider.notifier).init();
      }
      waitReadAPI = false;
    }
  }
}
