import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/call_back_function.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_animation_path.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/animation_download_util.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/utils/trade_timer_util.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_experience_info_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_coin_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_division_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_volume_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_time_provider.dart';
import 'package:treasure_nft_project/view_models/trade/trade_new_main_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/views/trade/reserve_loading_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/count_down_timer.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../constant/enum/trade_enum.dart';
import '../../models/http/parameter/check_experience_info.dart';
import '../../models/http/parameter/check_reservation_info.dart';
import '../../models/http/parameter/check_reserve_deposit.dart';
import '../../models/http/parameter/reserve_view_data.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../view_models/gobal_provider/user_info_provider.dart';
import '../../view_models/trade/provider/trade_reserve_info_provider.dart';
import '../../widgets/dialog/img_title_dialog.dart';

///MARK: 交易 切換交易等級&轉轉轉方塊
class TradeMainLevelView extends ConsumerStatefulWidget {
  const TradeMainLevelView(
      {Key? key, required this.viewModel, required this.onScrollTop})
      : super(key: key);
  final TradeNewMainViewModel viewModel;
  final onClickFunction onScrollTop;

  @override
  ConsumerState createState() => _TradeMainLevelViewState();
}

class _TradeMainLevelViewState extends ConsumerState<TradeMainLevelView> {
  TradeNewMainViewModel get viewModel {
    return widget.viewModel;
  }

  UserInfoData get userInfo {
    return ref.read(userInfoProvider);
  }

  ExperienceInfo get experienceInfo {
    return ref.read(userExperienceInfoProvider);
  }

  ReserveViewData? get reserveVolume {
    return ref.read(tradeReserveVolumeProvider);
  }

  CheckReserveDeposit? get reserveCoin {
    return ref.read(tradeReserveCoinProvider);
  }

  ///MARK:區間(Lv)
  int get currentDivisionIndex {
    return ref.read(tradeCurrentDivisionIndexProvider);
  }

  List<int> get reserveDivision {
    return ref.read(tradeReserveDivisionProvider);
  }

  ///MARK: 區間底下的ranges(錢的range）
  int get currentDivisionRangeIndex {
    return ref.read(tradeCurrentRangeIndexProvider);
  }

  CheckReservationInfo? get reserveInfo {
    return ref.read(tradeReserveInfoProvider);
  }

  SellingState get sellStatus {
    return ref.read(tradeTimeProvider)?.status ?? SellingState.NotYet;
  }

  String get timeTitle {
    switch (sellStatus) {
      case SellingState.NotYet:
        return tr('appTradeNotYet');
      case SellingState.Reserving:
        return tr('appTradeReserving');
      case SellingState.End:
        return tr('appTradeEnd');
    }
  }

  List<ReserveRange> get reserveDivisionRanges {
    if (reserveInfo != null) {
      var ranges = reserveInfo!.reserveRanges;

      /// 如果是體驗帳號 且 level 1 副本顯示內容不同
      if (experienceInfo.isExperience == true && userInfo.level == 1) {
        ranges[0].startPrice = 1;
        ranges[0].endPrice = 50;
        ranges[1].startPrice = 50;
        ranges[1].endPrice = 150;
      }
      return ranges;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    ///MARK: 強制監聽
    ref.watch(userInfoProvider);
    ref.watch(userExperienceInfoProvider);
    ref.watch(tradeReserveVolumeProvider);
    ref.watch(tradeReserveInfoProvider);
    ref.watch(tradeReserveCoinProvider);
    ref.watch(tradeReserveDivisionProvider);
    ref.watch(tradeCurrentDivisionIndexProvider);
    ref.watch(tradeCurrentRangeIndexProvider);
    ref.watch(tradeTimeProvider);

    ///MARK: 建立畫面
    return Column(
      children: [
        /// 交易的主要區塊
        _buildDivision(),

        // SizedBox(height: UIDefine.getPixelWidth(10)),

        /// 交易的其他資訊
        // _buildSystemInfo(),
      ],
    );
  }

  ///MARK: 中間選擇副本區間
  Widget _buildDivision() {
    bool isReserved = false;
    bool isLock = false;
    try {
      isReserved = reserveDivisionRanges[currentDivisionRangeIndex].used;
    } catch (e) {}
    try {
      isLock = reserveDivisionRanges[currentDivisionRangeIndex].lock;
    } catch (e) {}

    return Container(
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///MARK: 交易選擇區間&價格
          Row(
            children: [
              Expanded(child: _buildDivisionDropButton()),
              SizedBox(width: UIDefine.getPixelWidth(10)),
              Expanded(child: _buildRangeDropButton()),
            ],
          ),

          ///MARK: 顯示預約的剩餘時間
          _buildTimeBar(userInfo),

          ///MARK: 顯示交易的骰子圖片&3D動畫
          _buildTradeImage(isReserved, userInfo),

          ///MARK: 顯示交易區間的資訊
          _buildDivisionInfo(),

          SizedBox(height: UIDefine.getPixelWidth(10)),

          ///MARK: 預約交易的按鈕
          _buildReservationButton(isReserved, isLock, userInfo, experienceInfo),
        ],
      ),
    );
  }

  Widget _buildDivisionDropButton() {
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.textSixBlack, radius: 8, borderLine: 0.5),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(3)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton2(
        customButton: _buildDivisionDropItem(currentDivisionIndex, false, true),
        isExpanded: true,
        items: List<DropdownMenuItem<int>>.generate(reserveDivision.length,
            (index) {
          return DropdownMenuItem<int>(
              value: index, child: _buildDivisionDropItem(index, true, false));
        }),
        value: reserveDivision.isEmpty ? null : currentDivisionIndex,
        onChanged: (value) {
          if (value != null) {
            _onDivisionChange(divisionIndex: value);
          }
        },
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      )),
    );
  }

  Widget _buildDivisionDropItem(
      int index, bool needGradientText, bool needArrow) {
    if (reserveDivision.isEmpty) {
      return SizedBox(height: UIDefine.getPixelWidth(40));
    }
    var text = 'LV ${reserveDivision[index]}';
    return Container(
      alignment: Alignment.centerLeft,
      height: UIDefine.getPixelWidth(40),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          currentDivisionIndex == index && needGradientText
              ? GradientThirdText(
                  text,
                  size: UIDefine.fontSize12,
                )
              : Text(
                  text,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textSixBlack,
                      fontWeight: FontWeight.w600),
                ),
          const Spacer(),
          Visibility(
              visible: needArrow,
              child: BaseIconWidget(
                  imageAssetPath: AppImagePath.arrowDownGrey,
                  size: UIDefine.getPixelWidth(15)))
        ],
      ),
    );
  }

  Widget _buildRangeDropButton() {
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          color: AppColors.textSixBlack, radius: 8, borderLine: 0.5),
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(3)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: _buildRangDropItem(currentDivisionRangeIndex, false, true),
          isExpanded: true,
          hint: Row(
            children: [
              TetherCoinWidget(size: UIDefine.getPixelWidth(15)),
              SizedBox(width: UIDefine.getPixelWidth(5)),
              Text('0 - 0',
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textSixBlack,
                      fontWeight: FontWeight.w600))
          ]),
        items: List<DropdownMenuItem<int>>.generate(
            reserveDivisionRanges.length,
            (index) => DropdownMenuItem<int>(
                value: index, child: _buildRangDropItem(index, true, false))),
        value: reserveDivisionRanges.isEmpty ? null : currentDivisionRangeIndex,
        onChanged: (value) {
          if (value != null) {
            _onRangeChange(rangeIndex: value);
          }
        },
        buttonHeight: 40,
        dropdownMaxHeight: 200,
        buttonWidth: 140,
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      )),
    );
  }

  Widget _buildRangDropItem(int index, bool needGradientText, bool needArrow) {
    if (reserveDivisionRanges.isEmpty) {
      return SizedBox(height: UIDefine.getPixelWidth(40));
    }
    if (reserveDivisionRanges.length < index) {
      return SizedBox(height: UIDefine.getPixelWidth(40));
    }

    var text =
        '${NumberFormatUtil().numberCompatFormat(reserveDivisionRanges[index].startPrice.toString(), decimalDigits: 0)}'
        '-${NumberFormatUtil().numberCompatFormat(reserveDivisionRanges[index].endPrice.toString(), decimalDigits: 0)}';

    return Container(
      alignment: Alignment.centerLeft,
      height: UIDefine.getPixelWidth(40),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          TetherCoinWidget(size: UIDefine.getPixelWidth(15)),
          SizedBox(width: UIDefine.getPixelWidth(5)),
          index == currentDivisionRangeIndex && needGradientText
              ? GradientThirdText(
                  text,
                  size: UIDefine.fontSize12,
                )
              : Text(
                  text,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      color: AppColors.textSixBlack,
                      fontWeight: FontWeight.w600),
                ),
          const Spacer(),
          Visibility(
              visible: needArrow,
              child: BaseIconWidget(
                  imageAssetPath: AppImagePath.arrowDownGrey,
                  size: UIDefine.getPixelWidth(15)))
        ],
      ),
    );
  }

  Widget _buildTimeBar(UserInfoData userInfoData) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(timeTitle,
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: UIDefine.fontSize12)),
          Container(
            margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
            child: CountDownTimer(
              isNewType: true,
              duration: ref.watch(tradeTimeProvider)?.duration,
            ),
          ),
          Text(TradeTimerUtil().getTradeZone(userInfoData),
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: UIDefine.fontSize12)),
        ],
      ),
    );
  }

  Widget _buildTradeImage(bool isReserved, UserInfoData userInfoData) {
    bool needAddIndex = userInfoData.level > 0;
    if (isReserved) {
      String size = '';
      switch (currentDivisionRangeIndex) {
        case 0:
          {
            size = "200";
          }
          break;
        case 1:
          {
            size = "250";
          }
          break;
        case 2:
          {
            size = "300";
          }
          break;
        case 3:
          {
            size = "350";
          }
          break;

        case 4:
        default:
          {
            size = "400";
          }
          break;
      }

      if (userInfoData.level == 0) {
        size = "400";
      }

      String animationPath = format(AppAnimationPath.reservationDice3D, {
        "level": currentDivisionIndex + (needAddIndex ? 1 : 0),
        "size": size
      });
      String? path =
          AnimationDownloadUtil().getAnimationFilePath(animationPath);
      if (path != null) {
        return Container(
            alignment: Alignment.center,
            child: Image.file(
              height:
                  UIDefine.getPixelWidth(200 + currentDivisionRangeIndex * 50),
              width: UIDefine.getWidth(),
              File(path),
              fit: BoxFit.contain,
            ));
      }
    }
    // int index = 5 - viewModel.currentRangeIndex;
    // if (viewModel.currentDivisionIndex == 0) {
    //   index = 1;
    // }
    String imagePath = format(AppImagePath.tradeDiceImage, {
      "level": (currentDivisionIndex + (needAddIndex ? 1 : 0)).toString(),
      "index": NumberFormatUtil().integerTwoFormat(1)
    });
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: SizedBox(
        height: UIDefine.getPixelWidth(200 + currentDivisionRangeIndex * 50),
        width: UIDefine.getWidth(),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildDivisionInfo() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _buildDivisionInfoItem(
          title: tr('reservationTime'),
          context: TradeTimerUtil().getReservationTime()),

      /// MARK: 預約結果
      // _buildDivisionInfoItem(
      //     title: tr('NFTResultTime'),
      //     context: TradeTimerUtil().getResultTime()),

      /// Mark 預約金
      // _buildDivisionInfoItem(
      //     title: tr('reservationFee'),
      //     context: NumberFormatUtil().integerFormat(reserveCoin?.deposit ?? 0)),
      _buildDivisionInfoItem(
        title: tr("pfIncome"),
        needCoin: true,
        context: reserveDivisionRanges.isNotEmpty?
        "${getPfIncome(userInfo.level, currentDivisionIndex, currentDivisionRangeIndex)}USDT":"0 - 0USDT",
        color: AppColors.coinColorGreen,
        weight: FontWeight.w600,
      ),
      _buildDivisionInfoItem(
          title: tr('transactionReward'),
          context:
          reserveDivisionRanges.isNotEmpty?
          // "${reserveDivisionRanges[currentDivisionRangeIndex].rewardRate} %":""
          // "${currentDivisionIndex.runtimeType},${reserveDivisionRanges[currentDivisionRangeIndex].startPrice.runtimeType},${reserveDivisionRanges[currentDivisionRangeIndex].endPrice.runtimeType}":""
          "${getLevelReward(userInfo.level, currentDivisionIndex)}%":"",
          //     '${NumberFormatUtil().removeTwoPointFormat(reserveCoin?.reward ?? 0)} %'),
      )
    ]);
  }

  Widget _buildDivisionInfoItem(
      {required String title, required String context, bool needCoin = false,
        Color color = AppColors.textSixBlack, FontWeight weight = FontWeight.w400}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Row(
        children: [
          Text(title,
              style: AppTextStyle.getBaseStyle(
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: UIDefine.fontSize14)),
          const Spacer(),
          Visibility(
              visible: needCoin,
              child: TetherCoinWidget(size: UIDefine.getPixelWidth(12))),
          SizedBox(width: UIDefine.getPixelWidth(5)),
          Text(context,
              style: AppTextStyle.getBaseStyle(
                  color: color,
                  fontWeight: weight,
                  fontSize: UIDefine.fontSize14)),
        ],
      ),
    );
  }

  Widget _buildReservationButton(bool isReserved, bool isLock,
      UserInfoData userInfo, ExperienceInfo experienceInfo) {
    ///MARK: 如果鎖定 or 不允許使用交易功能時，要隱藏
    if (isLock || !(GlobalData.appTradeEnterButtonStatus)) {
      return const SizedBox();
    }
    if (reserveDivision.isEmpty || reserveDivisionRanges.isEmpty) {
      return const SizedBox();
    }
    EdgeInsetsGeometry buttonMargin = EdgeInsets.symmetric(
        horizontal: UIDefine.getPixelWidth(0),
        vertical: UIDefine.getPixelWidth(0));
    EdgeInsetsGeometry buttonPadding = EdgeInsets.symmetric(
        horizontal: UIDefine.getPixelWidth(0),
        vertical: UIDefine.getPixelWidth(0));

    return isReserved
        ? Row(
            children: [
              Expanded(
                  child: LoginBolderButtonWidget(
                      margin: buttonMargin,
                      padding: buttonPadding,
                      radius: 22,
                      fontWeight: FontWeight.w600,
                      fontSize: UIDefine.fontSize16,
                      btnText: tr('continueReservation'),
                      onPressed: () => widget.onScrollTop())),
              SizedBox(width: UIDefine.getPixelWidth(5)),
              Expanded(
                  child: LoginButtonWidget(
                margin: buttonMargin,
                padding: buttonPadding,
                radius: 22,
                fontWeight: FontWeight.w600,
                fontSize: UIDefine.fontSize16,
                btnText: tr('matching'),
                onPressed: () => viewModel.pushAndRemoveUntil(
                    context,
                    const MainPage(
                      type: AppNavigationBarType.typeCollection,
                    )),
              ))
            ],
          )
        : LoginButtonWidget(
            enable: sellStatus == SellingState.Reserving,
            isUnEnableGradient: false,
            margin: buttonMargin,
            padding: buttonPadding,
            radius: 22,
            fontWeight: FontWeight.w600,
            fontSize: UIDefine.fontSize16,
            btnText: tr('confirm'),
            onPressed: () {
              if (sellStatus == SellingState.Reserving) {
                _onPressReservation(userInfo, experienceInfo);
              }
            });
  }

  ///MARK: 交易量
  Widget _buildSystemInfo() {
    return Container(
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSystemInfoItem(tr('lastDayAmount'),
                  '\$ ${NumberFormatUtil().removeTwoPointFormat(reserveVolume?.vol ?? 0)}'),
              _buildSystemInfoItem(tr('PRICE'),
                  '${NumberFormatUtil().removeTwoPointFormat(reserveVolume?.price ?? 0)} \$')
            ],
          )),
          SizedBox(width: UIDefine.getPixelWidth(10)),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSystemInfoItem(tr('annualROI'),
                  '${NumberFormatUtil().removeTwoPointFormat(reserveVolume?.annualRoi ?? 0)} %'),
              _buildSystemInfoItem(tr('IRR'),
                  '${NumberFormatUtil().removeTwoPointFormat(7.5)} %')
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildSystemInfoItem(String title, String context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: AppTextStyle.getBaseStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textThreeBlack),
                ))),
        Container(
            alignment: Alignment.centerRight,
            child: Text(context,
                style: AppTextStyle.getBaseStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: UIDefine.fontSize14))),
      ],
    );
  }

  void _onPressReservation(
      UserInfoData userInfo, ExperienceInfo experienceInfo) async {

    /// add new reservation
    await viewModel.addNewReservation(
      context,
      reserveIndex: reserveDivisionRanges[currentDivisionRangeIndex].index,
      reserveStartPrice: reserveDivisionRanges[currentDivisionRangeIndex].startPrice,
      reserveEndPrice: reserveDivisionRanges[currentDivisionRangeIndex].endPrice);

    /// if reservation success 預約狀態 = true
    reserveDivisionRanges[currentDivisionRangeIndex].used = true;
    ref.read(tradeReserveInfoProvider)?.reserveRanges[currentDivisionRangeIndex].used = true;
    await ref.read(tradeReserveInfoProvider.notifier).setSharedPreferencesValue();

    _onDivisionChange(
        rangeIndex: currentDivisionRangeIndex,
        divisionIndex: currentDivisionIndex);
  }

  void _onDivisionChange({required int divisionIndex, int rangeIndex = 0}) {
    GlobalData.printLog('mainTrade_onDivisionChange:divisionIndex=$divisionIndex,rangeIndex=$rangeIndex');

    ///MARK: 初始化drop button
    ref.read(tradeCurrentRangeIndexProvider.notifier).state = rangeIndex;
    ref.read(tradeCurrentDivisionIndexProvider.notifier).state = divisionIndex;

    ///MARK: 設定對應值給查詢區間內的資料
    ref.read(tradeReserveInfoProvider.notifier).setCurrentChoose(reserveDivision[divisionIndex], null, null);

    ///MARK:查詢此區間
    ref.read(tradeReserveInfoProvider.notifier).init(onFinish: () {
      if (ref.read(tradeReserveInfoProvider)?.reserveRanges.isNotEmpty ??
          false) {
        _onRangeChange(rangeIndex: rangeIndex);
      }
    });
  }

  void _onRangeChange({required int rangeIndex}) {
    GlobalData.printLog('mainTrade_onRangeChange:rangeIndex=$rangeIndex');
    ref.read(tradeCurrentRangeIndexProvider.notifier).state = rangeIndex;
    ref.read(tradeReserveVolumeProvider.notifier).setDivisionIndex(reserveDivisionRanges[rangeIndex].index);
    ref.read(tradeReserveVolumeProvider.notifier).init();
    ref.read(tradeReserveCoinProvider.notifier).setSelectValue(
        reserveDivisionRanges[rangeIndex].index,
        reserveDivisionRanges[rangeIndex].startPrice,
        reserveDivisionRanges[rangeIndex].endPrice,
        reserveDivisionRanges[rangeIndex].rewardRate);
    ref.read(tradeReserveCoinProvider.notifier).init();
  }

  String getPfIncome(int userLevel, int chooseLevel, int index){
    num getReward = num.parse(getLevelReward(userLevel, chooseLevel));
    var startPrice = reserveDivisionRanges[index].startPrice;
    var endPrice = reserveDivisionRanges[index].endPrice;
    if (startPrice == 0.9) {
      startPrice = 1;
    }
    num pfStart = getReward * startPrice / 100;
    num pfEnd = getReward * endPrice / 100;
    return "${NumberFormatUtil().removeTwoPointFormat(pfStart)} - ${NumberFormatUtil().removeTwoPointFormat(pfEnd)}";
  }

  String getLevelReward(int userLevel, int chooseLevel) {
        print("choose: $chooseLevel");
    switch (userLevel) {
      case 0:
        double levelResult = 1.5;
        double num = levelResult*(chooseLevel+1);
        return NumberFormatUtil().removeOnePointFormat(num);
      case 1:
        double levelResult = 1.5;
        double num = levelResult*(chooseLevel+1);
        return NumberFormatUtil().removeOnePointFormat(num);
      case 2:
        double levelResult = 1.7;
        double num = levelResult*(chooseLevel+1);
        return NumberFormatUtil().removeOnePointFormat(num);
      case 3:
        double levelResult = 1.9;
        double num = levelResult*(chooseLevel+1);
        return NumberFormatUtil().removeOnePointFormat(num);
      case 4:
        double levelResult = 2.1;
        double num = levelResult*(chooseLevel+1);
        return NumberFormatUtil().removeOnePointFormat(num);
      case 5:
        double levelResult = 2.3;
        double num = levelResult*(chooseLevel+1);
        return NumberFormatUtil().removeOnePointFormat(num);
      case 6:
        double levelResult = 2.5;
        double num = levelResult*(chooseLevel+1);
        return NumberFormatUtil().removeOnePointFormat(num);
      default:
        double levelResult = 0;
        double num = levelResult*(chooseLevel+1);
        return NumberFormatUtil().removeOnePointFormat(num);
    }
  }
}
