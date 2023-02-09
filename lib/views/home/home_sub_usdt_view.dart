import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/home/widget/home_usdt_info.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../view_models/home/home_main_viewmodel.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../../widgets/list_view/home/carousel_listview.dart';
import '../main_page.dart';

class HomeSubUsdtView extends StatelessWidget {
  const HomeSubUsdtView({Key? key, required this.viewModel}) : super(key: key);
  final HomeMainViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
     // padding: viewModel.getMainPadding(height: 10),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImagePath.firstBackground),
              fit: BoxFit.fill)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Trade
          Padding(
            padding: viewModel.getMainPadding(height: 10),
            child: Row(
              children: [
                LoginButtonWidget(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(
                        horizontal: UIDefine.getPixelWidth(15)),
                    isFillWidth: false,
                    radius: 43,
                    btnText: tr('exploreNow'),
                    fontSize: UIDefine.fontSize20,
                    onPressed: () {
                      viewModel.pushAndRemoveUntil(
                          context,
                          const MainPage(
                              type: AppNavigationBarType.typeExplore));
                    }),
              ],
            ),
          ),

          viewModel.buildSpace(height: 5),

          /// USDT_Info
          HomeUsdtInfo(viewModel: viewModel),

          viewModel.buildSpace(height: 5),

          /// 輪播圖
          Padding(
              padding: viewModel.getMainPadding(height: 10),
              child: CarouselListView(viewModel: viewModel))
        ],
      ),
    );
  }
}
