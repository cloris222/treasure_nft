import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/personal/orders/order_detail_viewmodel.dart';
import 'package:treasure_nft_project/widgets/slider_page_view.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
import '../personal_new_sub_user_info_view.dart';
import 'order_detail_Info.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late OrderDetailViewModel viewModel;
  List<String> titles = [
    tr("TopPicks"),
    tr("Team"),
    tr("mine"),
    tr("goldStorageTank")
  ];

  @override
  initState() {
    super.initState();
    viewModel = OrderDetailViewModel(
      padding: EdgeInsets.only(bottom: UIDefine.navigationBarPadding),
      onListChange: () {
        setState(() {});
      },
    );
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
        needScrollView: true,
        body: _buildPageView(context),
        type: AppNavigationBarType.typePersonal);
  }

  Widget _buildTopView(BuildContext context) {
    return Container(
      color: AppColors.textWhite,
      padding: EdgeInsets.all(UIDefine.getScreenWidth(2.7)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImagePath.arrowLeftBlack),
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.textWhite.withOpacity(0.8)),
                  child: Column(
                    children: [
                      Text(
                        tr('totalRevenue'),
                        style: TextStyle(fontSize: UIDefine.fontSize12),
                      ),
                      SizedBox(height: UIDefine.getScreenWidth(2.7)),
                      Text(
                        viewModel.income.toStringAsFixed(2),
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
                  viewModel: viewModel, type: EarningIncomeType.ALL),
              OrderDetailInfo(
                  viewModel: viewModel, type: EarningIncomeType.TEAM),
              OrderDetailInfo(
                  viewModel: viewModel, type: EarningIncomeType.MINE),
              OrderDetailInfo(
                  viewModel: viewModel, type: EarningIncomeType.SAVINGS)
            ]));
  }

  /// 依點選button切換內容及total income
  void _getPageIndex(int value) {
    viewModel.type = EarningIncomeType.values[value];
    viewModel.initState();
  }
}
