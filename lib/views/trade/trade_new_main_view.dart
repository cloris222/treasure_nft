import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/view_models/trade/trade_new_main_view_model.dart';
import 'package:treasure_nft_project/views/trade/trade_main_level_view.dart';
import 'package:treasure_nft_project/views/trade/trade_main_user_info_view.dart';
import 'package:treasure_nft_project/widgets/label/icon/level_icon_widget.dart';

class TradeNewMainView extends StatefulWidget {
  const TradeNewMainView({Key? key}) : super(key: key);

  @override
  State<TradeNewMainView> createState() => _TradeNewMainViewState();
}

class _TradeNewMainViewState extends State<TradeNewMainView> {
  Color backgroundColor = const Color(0xFFF8F8F8);
  late TradeNewMainViewModel viewModel;

  @override
  void initState() {
    viewModel = TradeNewMainViewModel(onViewChange: () {
      if (mounted) {
        setState(() {});
      }
    });
    viewModel.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTitle(),

            ///微小的彩虹色露出O_O
            Container(
                height: 1, width: UIDefine.getWidth(), color: backgroundColor),
            Container(
              width: UIDefine.getWidth(),
              padding: EdgeInsets.only(
                  left: UIDefine.getPixelWidth(15),
                  right: UIDefine.getPixelWidth(15),
                  bottom: UIDefine.navigationBarPadding),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ///MARK: 使用者錢包相關資訊
                TradeMainUserInfoView(viewModel: viewModel),
                SizedBox(height: UIDefine.getPixelWidth(10)),
                TradeMainLevelView(viewModel: viewModel),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      decoration: AppStyle().buildGradient(
          borderWith: 0, colors: AppColors.gradientBackgroundColorNoFloatBg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: UIDefine.getPixelWidth(15),
                vertical: UIDefine.getPixelWidth(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LevelIconWidget(
                    level: GlobalData.userInfo.level,
                    needBig: true,
                    size: UIDefine.getPixelWidth(40)),
                Text(
                  '${tr('level')} ${GlobalData.userInfo.level}',
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  tr('trade-rules'),
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF5CBFFE)),
                ),
              ],
            ),
          ),
          Container(
            height: UIDefine.getPixelWidth(15),
            width: UIDefine.getWidth(),
            decoration: AppStyle().styleColorsRadiusBackground(
                color: backgroundColor,
                hasBottomRight: false,
                hasBottomLef: false),
          )
        ],
      ),
    );
  }
}
