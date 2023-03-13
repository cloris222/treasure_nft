import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';

import '../../../constant/enum/team_enum.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_style.dart';
import '../../../constant/ui_define.dart';
import '../../../utils/app_text_style.dart';
import '../../../widgets/date_picker/custom_date_picker.dart';
import '../../../widgets/list_view/level/level_referral_bonus_record_list_view.dart';
import '../../../widgets/list_view/level/level_trade_bonus_record_list_view.dart';

class LevelBonusRecordPage extends StatefulWidget {
  const LevelBonusRecordPage({Key? key, required this.isInitReferralBonus})
      : super(key: key);

  ///起始頁是否為推廣儲金罐
  final bool isInitReferralBonus;

  @override
  State<LevelBonusRecordPage> createState() => _LevelBonusRecordPageState();
}

class _LevelBonusRecordPageState extends State<LevelBonusRecordPage> {
  ItemScrollController listController = ItemScrollController();
  late PageController pageController;
  late int currentIndex;
  late int initIndex;
  String startTime = '';
  String endTime = '';

  @override
  void initState() {
    initIndex = widget.isInitReferralBonus ? 0 : 1;
    pageController = PageController(initialPage: initIndex);
    currentIndex = initIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        body: _buildBody(context),
        needScrollView: false,
        onLanguageChange: () {
          if (mounted) {
            setState(() {});
          }
        });
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
          child: _buildButtonList(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
          child: CustomDatePickerWidget(
            typeList: const [
              Search.Today,
              Search.Yesterday,
              Search.ThisWeek,
              Search.ThisMonth
            ],
            dateCallback: _onDataCallback,
            needCancel: true,
          ),
        ),
        SizedBox(height: UIDefine.getPixelWidth(15)),
        Expanded(
          child: Container(
            decoration: AppStyle().styleColorsRadiusBackground(
                color: AppColors.defaultBackgroundSpace,
                radius: 12,
                hasBottomLef: false,
                hasBottomRight: false),
            padding:
                EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20)),
            child: PageView(
              controller: pageController,
              onPageChanged: _onPageChange,
              children: [
                LevelReferralBonusRecordListView(
                    startTime: startTime, endTime: endTime),
                LevelTradeBonusRecordListView(
                    startTime: startTime, endTime: endTime)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildButtonList() {
    List<String> titles = [tr('bonus_referral'), tr('bonus_trade')];
    return Stack(
      children: [
        Container(
          height: UIDefine.getPixelWidth(50),
          width: UIDefine.getWidth(),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.lineBarGrey))),
        ),
        Positioned(
          top: 0,
          bottom: 1,
          left: 0,
          right: 0,
          child: SizedBox(
              height: UIDefine.getPixelWidth(50),
              child: ScrollablePositionedList.builder(
                  initialScrollIndex: initIndex,
                  scrollDirection: Axis.horizontal,
                  itemScrollController: listController,
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    return _buildButton(index, titles[index]);
                  })),
        ),
      ],
    );
  }

  void _onPageChange(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  Widget _buildButton(int index, String type) {
    bool isCurrent = (currentIndex == index);
    return InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
            pageController.jumpToPage(index);
          });
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(height: UIDefine.getPixelWidth(10)),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  height: UIDefine.getPixelWidth(38),
                  padding: EdgeInsets.symmetric(
                      vertical: UIDefine.getPixelWidth(5),
                      horizontal: UIDefine.getPixelWidth(23)),
                  child: Text(
                    type,
                    style: AppTextStyle.getBaseStyle(
                        color: isCurrent
                            ? AppColors.textBlack
                            : AppColors.textThreeBlack,
                        fontSize: UIDefine.fontSize16,
                        fontWeight: isCurrent ? FontWeight.w600 : null),
                  )),
              // Positioned(
              //     bottom: 0,
              //     left: 0,
              //     right: 0,
              //     child: Container(
              //       height: 1,
              //       color: AppColors.lineBarGrey,
              //     )),
              Positioned(
                  bottom: 0,
                  child: Visibility(
                    visible: isCurrent,
                    child: Container(
                      height: 4,
                      width: UIDefine.getPixelWidth(20),
                      decoration: AppStyle().baseGradient(radius: 3),
                    ),
                  ))
            ],
          ),
          // SizedBox(height: UIDefine.getPixelWidth(5)),
        ]));
  }

  void _onDataCallback(String startDate, String endDate) {
    if (startDate.compareTo(startTime) != 0 ||
        endDate.compareTo(endTime) != 0) {
      setState(() {
        startTime = startDate;
        endTime = endDate;
      });
    }
  }
}
