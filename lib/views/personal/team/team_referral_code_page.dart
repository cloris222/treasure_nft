import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/views/personal/personal_sub_user_info_view.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../custom_appbar_view.dart';

///MARK: 分享
class TeamReferralCodePage extends StatelessWidget {
  const TeamReferralCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      title: tr('shareCenter'),
      body: Column(
        children: const [PersonalSubUserInfoView()],
      ),
      type: AppNavigationBarType.typePersonal,
    );
  }
}
