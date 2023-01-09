import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/enum/setting_enum.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/personal/orders/order_detail_viewmodel.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/appbar/title_app_bar.dart';
import 'package:treasure_nft_project/widgets/slider_page_view.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';
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
      needCover: true,
      needScrollView: true,
      body: _buildPageView(context),
      type: AppNavigationBarType.typePersonal,
    );
  }

  Widget _buildTotalEarningsTitle(BuildContext context) {
    TextStyle styleGrey = AppTextStyle.getBaseStyle(
        color: AppColors.textGrey,
        fontSize: UIDefine.fontSize18,
        fontWeight: FontWeight.w500);
    TextStyle styleBlack = AppTextStyle.getBaseStyle(
        color: AppColors.opacityBackground,
        fontSize: UIDefine.fontSize18,
        fontWeight: FontWeight.w500);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr("totalRevenue"),
          style: styleGrey,
        ),
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          AppImagePath.tetherImg,
          width: 20,
          height: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          viewModel.income.toStringAsFixed(2),
          style: styleBlack,
        )
      ],
    );
  }

  Widget _buildTopView(BuildContext context) {
    return Column(
      children: [
        TitleAppBar(title: tr('myEarnings')),
        const PersonalSubUserInfoView(),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: UIDefine.getHeight() / 12,
            child: _buildTotalEarningsTitle(context)),
      ],
    );
  }

  Widget _buildPageView(BuildContext context) {
    return SliderPageView(
        titles: titles,
        initialPage: 0,
        topView: _buildTopView(context),
        onPageListener: _getPageIndex,
        children: [
          OrderDetailInfo(viewModel: viewModel, type: EarningIncomeType.ALL),
          OrderDetailInfo(viewModel: viewModel, type: EarningIncomeType.TEAM),
          OrderDetailInfo(viewModel: viewModel, type: EarningIncomeType.MINE),
          OrderDetailInfo(viewModel: viewModel, type: EarningIncomeType.SAVINGS)
        ]);
  }

  /// 依點選button切換內容及total income
  void _getPageIndex(int value) {
    viewModel.type = EarningIncomeType.values[value];
    viewModel.initState();
  }
}
