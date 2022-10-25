import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/appbar/custom_app_bar.dart';

import '../../../constant/theme/app_image_path.dart';
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: UIDefine.getWidth() / 20,
              vertical: UIDefine.getHeight() / 30),
          child: Column(
            children: [_buildTitle(context), _buildVideoGrid(context)],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(
          initType: AppNavigationBarType.typePersonal),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppImagePath.userGradient),
        const SizedBox(
          width: 5,
        ),
        Text(
          tr("instructionalVideo"),
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: UIDefine.fontSize20),
        )
      ],
    );
  }

  Widget _buildVideoGrid(BuildContext context) {
    return GridView(

      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1.2,),
      children: [Container(color: Colors.red,),Container(color: Colors.red,)],
    );
  }
}
