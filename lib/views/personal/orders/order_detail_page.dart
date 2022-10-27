import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/user_property.dart';
import 'package:treasure_nft_project/view_models/personal/orders/order_detail_viewmodel.dart';
import 'package:treasure_nft_project/views/personal/orders/order_detail_all.dart';
import 'package:treasure_nft_project/views/personal/orders/order_detail_mine.dart';
import 'package:treasure_nft_project/views/personal/orders/order_detail_team.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/slider_page_view.dart';
import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';

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
  ];
  List<Widget> pageViews = [
    OrderDetailAll(),
    OrderDetailTeam(),
    OrderDetailMine(),
  ];

  @override
  initState() {
    super.initState();
    viewModel = OrderDetailViewModel(
      onListChange: () {
        setState(() {});
      },
    );
    viewModel.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      title: tr('myEarnings'),
      body: Column(
        children: [
          const PersonalSubUserInfoView(),
          SizedBox(
              height: UIDefine.getHeight() / 12,
              child: _buildTotalEarningsTitle(context)),
          _buildPageView(context)
        ],
      ),
      type: AppNavigationBarType.typePersonal,
    );
  }

  Widget _buildTotalEarningsTitle(BuildContext context) {
    TextStyle styleGrey = TextStyle(
        color: AppColors.textGrey,
        fontSize: UIDefine.fontSize14,
        fontWeight: FontWeight.w500);
    TextStyle styleBlack = TextStyle(
        color: AppColors.opacityBackground,
        fontSize: UIDefine.fontSize16,
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
          '${viewModel.userProperty?.income.toStringAsFixed(2)}',
          style: styleBlack,
        )
      ],
    );
  }

  Widget _buildPageView(BuildContext context) {
    return SliderPageView(titles: titles, initialPage: 0, children: pageViews);
  }
}
