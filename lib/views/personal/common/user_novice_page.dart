import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../widgets/app_bottom_navigation_bar.dart';

///MARK: 新手教程
class UserNovicePage extends StatelessWidget {
  const UserNovicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('uc_novice')),
      bottomNavigationBar:
      const AppBottomNavigationBar(initType: AppNavigationBarType.typePersonal),
    );
  }
}