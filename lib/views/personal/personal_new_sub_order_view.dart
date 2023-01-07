import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/utils/custom_text_style.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/user_order_info.dart';
import '../../view_models/base_view_model.dart';
import '../../widgets/app_bottom_navigation_bar.dart';
import '../../widgets/label/personal_param_item.dart';
import '../main_page.dart';
import 'orders/order_detail_page.dart';
import 'orders/order_info_page.dart';
import 'orders/order_recharge_page.dart';
import 'orders/order_withdraw_page.dart';

class PersonalNewSubOrderView extends StatelessWidget {
  const PersonalNewSubOrderView({super.key, this.userOrderInfo});
  final UserOrderInfo? userOrderInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColors.textWhite,
        child: Container(
          padding: EdgeInsets.all(UIDefine.getScreenWidth(3.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(tr('myOrder'), // 標題 我的訂單
                        style: AppTextStyle.getBaseStyle(color: AppColors.dialogBlack,
                            fontSize: UIDefine.fontSize20, fontWeight: FontWeight.w500)),
                  ),

                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _showOrderInfo(context),
                      child: Row(
                        children: [
                          Text(tr('seeOrder'), // 查看訂單
                              style: AppTextStyle.getBaseStyle(color: AppColors.dialogBlack,
                                  fontSize: UIDefine.fontSize12, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 4),
                          Image.asset(AppImagePath.rightArrow)
                        ],
                      )
                  )
                ],
              ),

              _getLine(),

              Row(
                children: [
                  Flexible(
                    child: PersonalParamItem(
                        title: tr('ord_all'), value: '${userOrderInfo?.total}'),
                  ),
                  Flexible(
                    child: PersonalParamItem(
                        title: tr('ord_pro'), value: '${userOrderInfo?.pending}'),
                  ),
                  Flexible(
                      child: PersonalParamItem(
                          title: tr('ord_bought'), value: '${userOrderInfo?.bought}')),
                  Flexible(
                    child: PersonalParamItem(
                        title: tr('ord_sold'), value: '${userOrderInfo?.sold}'),
                  ),
                ],
              ),

              Row(children: [
                Flexible(
                    child: PersonalParamItem(
                        title: tr('uc_myNFT'),
                        assetImagePath: AppImagePath.myNftIcon,
                        onPress: () => _showMyNftPage(context))),
                Flexible(
                    child: PersonalParamItem(
                        title: tr('uc_balDetail'),
                        assetImagePath: AppImagePath.myBalDetailIcon,
                        onPress: () => _showMyBalDetailPage(context))),
                Flexible(
                    child: PersonalParamItem(
                        title: tr('uc_recharge'),
                        assetImagePath: AppImagePath.myRechargeIcon,
                        onPress: () => _showMyRechargePage(context))),
                Flexible(
                    child: PersonalParamItem(
                        title: tr('uc_withdraw'),
                        assetImagePath: AppImagePath.myWithdrawIcon,
                        onPress: () => _showMyWithDrawPage(context)))
              ])

            ],
          )
        )
    );
  }

  Widget _getLine() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getScreenWidth(2.7)),
        width: double.infinity,
        height: 1,
        color: AppColors.searchBar
    );
  }

  void _showOrderInfo(BuildContext context) {
    BaseViewModel().pushPage(context, const OrderInfoPage());
  }

  void _showMyNftPage(BuildContext context) {
    BaseViewModel().pushReplacement(
        context, const MainPage(type: AppNavigationBarType.typeCollection));
  }

  void _showMyBalDetailPage(BuildContext context) {
    BaseViewModel().pushPage(context, const OrderDetailPage());
  }

  void _showMyRechargePage(BuildContext context) {
    BaseViewModel().pushPage(context, const OrderRechargePage());
  }

  void _showMyWithDrawPage(BuildContext context) {
    BaseViewModel().pushPage(context, const OrderWithdrawPage());
  }

}