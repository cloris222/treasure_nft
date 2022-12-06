import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/home/widget/home_usdt_info.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../view_models/home/home_main_viewmodel.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../../widgets/button/action_button_widget.dart';
import '../../widgets/list_view/home/carousel_listview.dart';
import '../main_page.dart';

class HomeSubUsdtView extends StatelessWidget {
  const HomeSubUsdtView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeMainViewModel viewModel = HomeMainViewModel();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImagePath.firstBackground),
              fit: BoxFit.fill)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        viewModel.buildSpace(height: 2),

        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr('index-product-text-1\''),
                  style: TextStyle(
                      fontSize: UIDefine.fontSize14,
                      color: AppColors.textGrey)),
              Text(tr('index-product-text-2\''),
                  style: TextStyle(
                      fontSize: UIDefine.fontSize14, color: AppColors.textGrey))
            ]),

        viewModel.buildSpace(height: 5),

        /// Trade
        ActionButtonWidget(
            radius: 8,
            setHeight: 45,
            btnText: tr('Trade'),
            fontSize: UIDefine.fontSize12,
            onPressed: () {
              viewModel.isLogin()
                  ? viewModel.pushAndRemoveUntil(context,
                      const MainPage(type: AppNavigationBarType.typeTrade))
                  : viewModel.pushAndRemoveUntil(context,
                      const MainPage(type: AppNavigationBarType.typeLogin));
            }),

        viewModel.buildSpace(height: 5),

        /// USDT_Info
        const HomeUsdtInfo(),

        viewModel.buildSpace(height: 10),

        /// 輪播圖
        const CarouselListView()
      ]),
    );
  }
}
