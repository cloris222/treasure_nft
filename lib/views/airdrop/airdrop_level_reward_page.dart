import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/view_models/base_view_model.dart';
import 'package:treasure_nft_project/widgets/button/login_button_widget.dart';

import '../../constant/enum/airdrop_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../models/http/parameter/treasure_box_record.dart';
import 'airdrop_common_view.dart';

class AirdropLevelRewardPage extends StatelessWidget with AirdropCommonView {
  AirdropLevelRewardPage({Key? key, required this.record}) : super(key: key);
  final TreasureBoxRecord record;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.opacityBackground,
      body: GestureDetector(
          onTap: () => BaseViewModel().popPage(context),
          child: Container(
              constraints: const BoxConstraints.expand(),
              color: Colors.transparent,
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: UIDefine.getPixelWidth(30)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: UIDefine.getPixelWidth(30)),
                        _buildRewardIcon(),
                        SizedBox(height: UIDefine.getPixelWidth(60)),
                        LoginButtonWidget(
                            radius: 22,
                            btnText: tr("appWow"),
                            onPressed: () => BaseViewModel().popPage(context)),
                      ],
                    ),
                  )))),
    );
  }

  Widget _buildRewardIcon() {
    List<AirdropRewardType> list =
        getRewardList(getRewardType(record.rewardType), true);
    return Row(
      children: List<Widget>.generate(
          list.length,
          (index) => Expanded(
                child: buildStackRewardIcon(record.changeReward(), list[index]),
              )),
    );
  }
}
