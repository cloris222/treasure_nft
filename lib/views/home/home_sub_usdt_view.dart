import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/views/home/widget/home_usdt_info.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/theme/app_image_path.dart';
import '../../constant/ui_define.dart';
import '../../view_models/control_router_viem_model.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../../widgets/list_view/home/carousel_listview.dart';
import '../main_page.dart';
import 'home_main_style.dart';

class HomeSubUsdtView extends StatelessWidget with HomeMainStyle {
  const HomeSubUsdtView({Key? key}) : super(key: key);

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
            padding: getMainPadding(height: 10),
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
                      ControlRouterViewModel().pushAndRemoveUntil(
                          context,
                          const MainPage(
                              type: AppNavigationBarType.typeExplore));
                    }),
              ],
            ),
          ),

          buildSpace(height: 5),

          /// USDT_Info
           // ignore: prefer_const_constructors
           HomeUsdtInfo(),

          buildSpace(height: 5),

          /// 輪播圖
          Padding(
              padding: getMainPadding(height: 10),
              child: const CarouselListView())
        ],
      ),
    );
  }
}
