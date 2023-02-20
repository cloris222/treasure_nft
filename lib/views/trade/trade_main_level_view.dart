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
import 'package:treasure_nft_project/utils/date_format_util.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/utils/trade_timer_util.dart';
import 'package:treasure_nft_project/view_models/gobal_provider/user_experience_info_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_coin_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_division_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_stage_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_reserve_volume_provider.dart';
import 'package:treasure_nft_project/view_models/trade/provider/trade_time_provider.dart';
import 'package:treasure_nft_project/view_models/trade/trade_new_main_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/login_bolder_button_widget.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';
import 'package:treasure_nft_project/widgets/count_down_timer.dart';
import 'package:treasure_nft_project/widgets/dialog/new_reservation_dialog.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

import '../../models/http/parameter/check_experience_info.dart';
import '../../models/http/parameter/check_reservation_info.dart';
import '../../models/http/parameter/check_reserve_deposit.dart';
import '../../models/http/parameter/reserve_view_data.dart';
import '../../models/http/parameter/trade_reserve_stage__info.dart';
import '../../models/http/parameter/user_info_data.dart';
import '../../view_models/gobal_provider/user_info_provider.dart';
import '../../view_models/trade/provider/trade_reserve_info_provider.dart';

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

  ///MARK:區間
  int get currentDivisionIndex {
    return ref.read(tradeCurrentDivisionIndexProvider);
  }

  List<int> get reserveDivision {
    return ref.read(tradeReserveDivisionProvider);
  }

  ///MARK: 區間底下的ranges
  int get currentDivisionRangeIndex {
    return ref.read(tradeCurrentRangeIndexProvider);
  }

  CheckReservationInfo? get reserveInfo {
    return ref.read(tradeReserveInfoProvider);
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

  int? get currentStageIndex {
    return ref.read(tradeCurrentStageProvider);
  }

  List<TradeReserveStageInfo> get reserveStages {
    return ref.read(tradeReserveStageProvider);
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
    ref.watch(tradeCurrentDivisionIndexProvider);
    ref.watch(tradeCurrentStageProvider);
    ref.watch(tradeReserveStageProvider);

    ///MARK: 建立畫面
    return Column(
      children: [
        /// 交易的主要區塊
        currentStageIndex == null ? _buildTimeStageView() : _buildDivision(),

        SizedBox(height: UIDefine.getPixelWidth(10)),

        /// 交易的其他資訊
        _buildSystemInfo(),
      ],
    );
  }

  ///MARK: 區間選擇
  Widget _buildTimeStageView() {
    return Container(
      padding: EdgeInsets.all(UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 12),
      child: Column(
        children: [
          Container(
              decoration: AppStyle().styleColorBorderBackground(
                  borderLine: 0.5,
                  radius: 6,
                  backgroundColor: const Color(0xFFF5F8FB),
                  color: AppColors.textSixBlack),
              padding: EdgeInsets.all(UIDefine.getPixelWidth(15)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(tr('selectionPeriod'),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize18,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: UIDefine.getPixelWidth(20)),
                ...List<Widget>.generate(
                    reserveStages.length, (index) => _buildStageItem(index)),
              ])),
          SizedBox(height: UIDefine.getPixelWidth(10)),

          ///MARK: 顯示交易區間的資訊
          _buildDivisionInfo(),
        ],
      ),
    );
  }

  bool checkReserve(DateTime startTime, DateTime endTime) {
    DateTime now = DateTime.now();
    return now.isBefore(startTime);
  }

  Widget _buildStageItem(int index) {
    TradeReserveStageInfo info = reserveStages[index];

    ///MARK: isAvailable 都顯示 false
    bool canReserve = checkReserve(info.startTime, info.endTime);
    return Container(
      decoration: AppStyle().styleColorBorderBackground(
          borderLine: 0.4,
          radius: 4,
          backgroundColor: Colors.white,
          color: const Color(0xFFC6CACC)),
      padding: EdgeInsets.all(UIDefine.getPixelWidth(8)),
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(5)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${DateFormatUtil().buildFormat(strFormat: 'MM-dd HH:mm', time: info.startTime)} ~'
              '\n${DateFormatUtil().buildFormat(strFormat: 'MM-dd HH:mm', time: info.endTime)}',
              textAlign: TextAlign.start,
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: Text(
              '${tr('balanceReservation')} : '
              '\n${NumberFormatUtil().removeTwoPointFormat(reserveInfo?.reserveBalance ?? 0)}',
              textAlign: TextAlign.start,
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSixBlack),
            ),
          ),
          Opacity(
            opacity: canReserve ? 1 : 0,
            child: LoginButtonWidget(
                height: UIDefine.getPixelWidth(40),
                padding:
                    EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(5)),
                fontSize: UIDefine.fontSize12,
                fontWeight: FontWeight.w600,
                isFillWidth: false,
                btnText: tr('reserve'),
                onPressed: () {
                  if (canReserve) {
                    _onChangeTimeStage(index);
                  }
                }),
          )
        ],
      ),
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
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => _onChooseTime(),
                        child: Image.asset(AppImagePath.tradeStageIcon)),
                    SizedBox(width: UIDefine.getPixelWidth(10)),
                    Expanded(child: _buildDivisionDropButton()),
                  ],
                ),
              ),
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
        customButton:
            _buildRangDropItem(currentDivisionRangeIndex, false, true),
        isExpanded: true,
        hint: Row(children: [
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
          Text(tr('timeLeft'),
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
      _buildDivisionInfoItem(
          title: tr('NFTResultTime'),
          context: TradeTimerUtil().getResultTime()),
      _buildDivisionInfoItem(
          title: tr('reservationFee'),
          context: NumberFormatUtil().integerFormat(reserveCoin?.deposit ?? 0)),
      _buildDivisionInfoItem(
          title: tr('transactionReward'),
          context:
              '${NumberFormatUtil().removeTwoPointFormat(reserveCoin?.reward ?? 0)} %'),
    ]);
  }

  Widget _buildDivisionInfoItem(
      {required String title, required String context, bool needCoin = false}) {
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
                  color: AppColors.textSixBlack,
                  fontWeight: FontWeight.w600,
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
            margin: buttonMargin,
            padding: buttonPadding,
            radius: 22,
            fontWeight: FontWeight.w600,
            fontSize: UIDefine.fontSize16,
            btnText: tr('confirm'),
            onPressed: () => _onPressReservation(userInfo, experienceInfo));
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
      UserInfoData userInfo, ExperienceInfo experienceInfo) {
    viewModel.pushOpacityPage(
        context,
        NewReservationPopUpView(
          confirmBtnAction: () async {
            Navigator.pop(context);

            /// add new reservation
            await viewModel.addNewReservation(
                reserveIndex:
                    reserveDivisionRanges[currentDivisionRangeIndex].index,
                reserveStartPrice:
                    reserveDivisionRanges[currentDivisionRangeIndex].startPrice,
                reserveEndPrice:
                    reserveDivisionRanges[currentDivisionRangeIndex].endPrice);

            /// if reservation success 預約狀態 = true
            reserveDivisionRanges[currentDivisionRangeIndex].used = true;

            /// 狀態更新
            setState(() {});

            _onDivisionChange(
                rangeIndex: currentDivisionRangeIndex,
                divisionIndex: currentDivisionRangeIndex);
          },
          reservationFee: '${reserveCoin?.deposit}',
          transactionTime: '${reserveCoin?.tradingTime}',
          transactionReward: '${reserveCoin?.reward}',
        ));
  }

  void _onChooseTime() {
    ref.read(tradeCurrentStageProvider.notifier).state = null;
  }

  void _onChangeTimeStage(int index) {
    ref.read(tradeCurrentStageProvider.notifier).state = index;

    ref.read(tradeReserveDivisionProvider.notifier).init(onFinish: () {
      if (ref.read(tradeReserveDivisionProvider).isNotEmpty) {
        _onDivisionChange(divisionIndex: 0);
      }
    });
  }

  void _onDivisionChange({required int divisionIndex, int rangeIndex = 0}) {
    ///MARK: 初始化drop button
    ref.read(tradeCurrentDivisionIndexProvider.notifier).state = divisionIndex;

    ///MARK: 設定對應值給查詢區間內的資料
    ref.read(tradeReserveInfoProvider.notifier).setCurrentChoose(
        reserveDivision[divisionIndex],
        currentStageIndex != null
            ? reserveStages[currentStageIndex!].stage
            : null,
        DateFormatUtil().getTimeWithDayFormat(
            time: currentStageIndex != null
                ? reserveStages[currentStageIndex!].startTime
                : null));

    ///MARK:查詢此區間
    ref.read(tradeReserveInfoProvider.notifier).init(onFinish: () {
      if (ref.read(tradeReserveInfoProvider)?.reserveRanges.isNotEmpty ??
          false) {
        _onRangeChange(rangeIndex: rangeIndex);
      }
    });
  }

  void _onRangeChange({required int rangeIndex}) {
    ref.read(tradeCurrentRangeIndexProvider.notifier).state = rangeIndex;
    ref.read(tradeReserveVolumeProvider.notifier).init();
    ref.read(tradeReserveCoinProvider.notifier).setSelectValue(
        reserveDivisionRanges[rangeIndex].index,
        reserveDivisionRanges[rangeIndex].startPrice,
        reserveDivisionRanges[rangeIndex].endPrice);
    ref.read(tradeReserveCoinProvider.notifier).init();
  }
}
