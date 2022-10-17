import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
      runSpacing: 15,
      children: [_buildTitle(), _buildCenter(), _buildButton()],
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [Text(tr('myOrder'))],
    );
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
      child: Row(
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
    );
  }
}
