import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/enum/team_enum.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/orders/order_detail_income_provider.dart';
import 'package:treasure_nft_project/widgets/slider_page_view.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
import '../personal_new_sub_user_info_view.dart';
import 'order_detail_Info.dart';

class OrderDetailPage extends ConsumerStatefulWidget {
  const OrderDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends ConsumerState<OrderDetailPage> {
  String startTime = '';
  String endTime = '';
  Search currentType = Search.All;
  EarningIncomeType currentIncomeType = EarningIncomeType.ALL;

  double get income {
    return ref.read(orderDetailIncomeProvider);
  }

  @override
  initState() {
    ref.read(orderDetailIncomeProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(orderDetailIncomeProvider);
    return CustomAppbarView(
      needScrollView: true,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: _buildPageView(context),
      type: AppNavigationBarType.typePersonal,
    );
  }

  Widget _buildTopView(BuildContext context) {
    return Container(
      color: AppColors.textWhite,
      padding: EdgeInsets.all(UIDefine.getScreenWidth(2.7)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AppImagePath.arrowLeftBlack),
          ),
          SizedBox(height: UIDefine.getScreenWidth(4.5)),
          Container(
            padding: EdgeInsets.all(UIDefine.getScreenWidth(4.5)),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  image: AssetImage('assets/icon/img/img_background_01.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                const PersonalNewSubUserInfoView(
                  showDailyTask: false,
                  enableModify: false,
                  showId: false,
                ),

                SizedBox(height: UIDefine.getScreenWidth(4.5)),

                /// 總收入框框
                Container(
                  padding: EdgeInsets.all(UIDefine.getScreenWidth(2.8)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AppColors.textWhite.withOpacity(0.8)),
                  child: Column(
                    children: [
                      Text(
                        tr('totalRevenue'),
                        style: TextStyle(fontSize: UIDefine.fontSize12),
                      ),
                      SizedBox(height: UIDefine.getScreenWidth(2.7)),
                      Text(
                        NumberFormatUtil().removeTwoPointFormat(income),
                        style: TextStyle(
                            fontSize: UIDefine.fontSize22,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    List<String> titles = [
      tr("TopPicks"),
      tr("Team"),
      tr("mine"),
      tr("goldStorageTank")
    ];
    return Container(
        color: AppColors.bolderGrey.withOpacity(0.5),
        child: SliderPageView(
            needMargin: true,
            buttonDecoration: const BoxDecoration(
                color: AppColors.textWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            titles: titles,
            initialPage: 0,
            topView: _buildTopView(context),
            onPageListener: _getPageIndex,
            children: [
              OrderDetailInfo(
                type: EarningIncomeType.ALL,
                startTime: startTime,
                endTime: endTime,
                currentType: currentType,
                dateCallback: _onDateChange,
                typeCallback: _onTypeChange,
              ),
              OrderDetailInfo(
                type: EarningIncomeType.TEAM,
                startTime: startTime,
                endTime: endTime,
                currentType: currentType,
                dateCallback: _onDateChange,
                typeCallback: _onTypeChange,
              ),
              OrderDetailInfo(
                type: EarningIncomeType.MINE,
                startTime: startTime,
                endTime: endTime,
                currentType: currentType,
                dateCallback: _onDateChange,
                typeCallback: _onTypeChange,
              ),
              OrderDetailInfo(
                type: EarningIncomeType.SAVINGS,
                startTime: startTime,
                endTime: endTime,
                currentType: currentType,
                dateCallback: _onDateChange,
                typeCallback: _onTypeChange,
              ),
            ]));
  }

  /// 依點選button切換內容及total income
  void _getPageIndex(int value) {
    setState(() {
      currentIncomeType = EarningIncomeType.values[value];
      ref.read(orderDetailIncomeProvider.notifier).setParam(
          type: currentIncomeType, startDate: startTime, endDate: endTime);
    });
  }

  void _onDateChange(String startDate, String endDate) {
    if (startDate.compareTo(startTime) != 0 ||
        endDate.compareTo(endTime) != 0) {
      setState(() {
        startTime = startDate;
        endTime = endDate;
        ref.read(orderDetailIncomeProvider.notifier).setParam(
            type: currentIncomeType, startDate: startDate, endDate: endDate);
      });
    }
  }

  void _onTypeChange(Search type) {
    if (currentType != type) {
      setState(() {
        currentType = type;
      });
    }
  }
}
