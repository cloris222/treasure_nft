import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/main_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/user_order_info.dart';
import '../../widgets/label/personal_param_item.dart';
import 'orders/order_detail_page.dart';
import 'orders/order_info_page.dart';
import 'orders/order_recharge_page.dart';
import 'orders/order_withdraw_page.dart';

class PersonalSubOrderView extends StatelessWidget {
  const PersonalSubOrderView({Key? key, this.userOrderInfo}) : super(key: key);
  final UserOrderInfo? userOrderInfo;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      children: [
        const SizedBox(width: 1),
        _buildTitle(context),
        _buildCenter(),
        _buildButton(context),
        const SizedBox(width: 1),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Image.asset(
        AppImagePath.myOrderIcon,
        width: UIDefine.getScreenWidth(8),
        fit: BoxFit.fitWidth,
      ),
      const SizedBox(width: 5),
      Text(tr('myOrder'),
          style: TextStyle(
              fontSize: UIDefine.fontSize20,
              fontWeight: FontWeight.bold,
              color: AppColors.dialogBlack)),
      Flexible(
          child: Container(
              alignment: Alignment.centerRight,
              width: UIDefine.getWidth(),
              child: InkWell(
                onTap: () => _showOrderInfo(context),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(tr('seeOrder'),
                      style: TextStyle(
                          fontSize: UIDefine.fontSize12,
                          color: AppColors.dialogGrey,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(width: 5),
                  Image.asset(AppImagePath.rightArrow)
                ]),
              )))
    ]);
  }

  Widget _buildCenter() {
    return Row(
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
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
        width: UIDefine.getWidth(),
        decoration: AppStyle().styleUserSetting(),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(children: [
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
        ]));
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
