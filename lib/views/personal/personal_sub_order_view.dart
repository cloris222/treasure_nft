import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';

import '../../constant/theme/app_colors.dart';
import '../../constant/theme/app_style.dart';
import '../../constant/ui_define.dart';
import '../../models/http/parameter/user_order_info.dart';
import '../../widgets/label/personal_param_item.dart';

class PersonalSubOrderView extends StatelessWidget {
  const PersonalSubOrderView({Key? key, this.userOrderInfo}) : super(key: key);
  final UserOrderInfo? userOrderInfo;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 25,
      children: [
        const SizedBox(width: 1),
        _buildTitle(),
        _buildCenter(),
        _buildButton(),
        const SizedBox(width: 1),
      ],
    );
  }

  Widget _buildTitle() {
    return Row(children: [
      Image.asset(AppImagePath.myOrderIcon),
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
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(tr('seeOrder'),
                    style: TextStyle(
                        fontSize: UIDefine.fontSize12,
                        color: AppColors.dialogGrey,
                        fontWeight: FontWeight.w500)),
                const SizedBox(width: 5),
                Image.asset(AppImagePath.rightArrow)
              ])))
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

  Widget _buildButton() {
    return Container(
        width: UIDefine.getWidth(),
        decoration: AppStyle().styleColorBorderBackground(
            color: AppColors.dialogGrey,
            radius: 10,
            backgroundColor: Colors.transparent),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(children: [
          Flexible(
              child: PersonalParamItem(
                  title: tr('uc_myNFT'),
                  assetImagePath: AppImagePath.myNftIcon,onPress: _showMyNftPage)),
          Flexible(
              child: PersonalParamItem(
                  title: tr('uc_balDetail'),
                  assetImagePath: AppImagePath.myBalDetailIcon,onPress: _showMyBalDetailPage)),
          Flexible(
              child: PersonalParamItem(
                  title: tr('uc_recharge'),
                  assetImagePath: AppImagePath.myRechargeIcon,onPress: _showMyRechargePage)),
          Flexible(
              child: PersonalParamItem(
                  title: tr('uc_withdraw'),
                  assetImagePath: AppImagePath.myWithdrawIcon,onPress: _showMyWithDrawPage))
        ]));
  }

  void _showMyNftPage() {
  }

  void _showMyBalDetailPage() {
  }

  void _showMyRechargePage() {
  }

  void _showMyWithDrawPage() {
  }
}
