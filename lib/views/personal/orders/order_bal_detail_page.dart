import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../constant/theme/app_colors.dart';
import '../../../constant/theme/app_image_path.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';

///MARK: 我的收益
class OrderBalDetailPage extends StatelessWidget {
  const OrderBalDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      title: tr('myEarnings'),
      body: Column(
        children: [
          const PersonalSubUserInfoView(),
          SizedBox(height: UIDefine.getHeight()/12,
              child: _buildTotalEarningsTitle(context))
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
        fontSize: UIDefine.fontSize14,
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
        Text('1,800.00',style: styleBlack,)
      ],
    );
  }
}
