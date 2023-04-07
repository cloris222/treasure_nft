import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';

///寶箱主頁
class AirdropMainPage extends StatefulWidget {
  const AirdropMainPage({Key? key}) : super(key: key);

  @override
  State<AirdropMainPage> createState() => _AirdropMainPageState();
}

class _AirdropMainPageState extends State<AirdropMainPage> {
  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      isAirDrop: true,
      needScrollView: false,
      needBottom: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(child: Text(tr("Home"), style: AppTextStyle.getBaseStyle()));
  }
}
