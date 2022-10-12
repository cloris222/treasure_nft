import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/widgets/domain_bar.dart';

import '../../constant/theme/app_image_path.dart';
import '../../widgets/dialog/custom_amount_dialog.dart';
import '../../widgets/dialog/edit_avatar_dialog.dart';

class TradeMainView extends StatelessWidget {
  const TradeMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [const DomainBar(), _countDownView(context)],
      ),
    );
  }

  Widget _countDownView(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImagePath.countDownBackground,
           width: UIDefine.getWidth(),
           height: UIDefine.getWidth(),
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
