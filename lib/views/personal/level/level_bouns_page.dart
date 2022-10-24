import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../view_models/base_view_model.dart';
import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/appbar/custom_app_bar.dart';

class LevelBonusPage extends StatefulWidget {
  const LevelBonusPage({Key? key}) : super(key: key);

  @override
  State<LevelBonusPage> createState() => _LevelBonusPageState();
}

class _LevelBonusPageState extends State<LevelBonusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getCommonAppBar(() {
        BaseViewModel().popPage(context);
      }, tr('bouns')),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildBody())),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typePersonal),
    );
  }

  Widget _buildBody() {
    return Column();
  }
}
