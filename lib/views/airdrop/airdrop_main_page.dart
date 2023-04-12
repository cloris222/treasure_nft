import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/views/airdrop/airdrop_daily_page.dart';
import 'package:treasure_nft_project/views/airdrop/airdrop_growth_page.dart';
import 'package:treasure_nft_project/views/airdrop/airdrop_soul_page.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';

import '../../constant/enum/airdrop_enum.dart';
import '../../constant/theme/app_colors.dart';
import '../../view_models/airdrop/airdrop_daily_boxInfo_provider.dart';
import '../../view_models/airdrop/airdrop_daily_record_provider.dart';
import '../../view_models/airdrop/airdrop_level_boxInfo_provider.dart';
import '../../view_models/airdrop/airdrop_level_record_provider.dart';
import '../../view_models/gobal_provider/user_info_provider.dart';
import 'airdrop_common_view.dart';

///寶箱主頁
class AirdropMainPage extends ConsumerStatefulWidget {
  const AirdropMainPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AirdropMainPageState();
}

class _AirdropMainPageState extends ConsumerState<AirdropMainPage>
    with AirdropCommonView {
  AirdropType currentType = AirdropType.values.first;
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initDailyProvider();
    initLevelProvider();
    super.initState();
  }

  void initLevelProvider() {
    for (int i = 1; i <= 6; i++) {
      ref.read(airdropLevelRecordProvider(i).notifier).init();
      ref.read(airdropLevelBoxInfoProvider(i).notifier).init();
    }
    int initLevel = ref.read(userInfoProvider).level;
    if (initLevel == 0) {
      initLevel = 1;
    }

    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => onChangeIndex(ref, initLevel));
  }

  void initDailyProvider() {
    ref.read(airdropDailyRecordProvider.notifier).init();
    ref.read(airdropDailyBoxInfoProvider.notifier).init();
  }

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
    return Container(
      decoration: AppStyle()
          .buildGradient(colors: AppColors.gradientBackgroundColorNoFloatBg),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(20)),
            child: Row(
              children: [
                SizedBox(width: UIDefine.getPixelWidth(20)),
                Text(tr('airdrop'),
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize28,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Expanded(child: _buildPage())
        ],
      ),
    );
  }

  Widget _buildPage() {
    return Container(
      decoration: AppStyle().styleColorsRadiusBackground(
          radius: 20,
          color: AppColors.airdropBackground.withOpacity(0.87),
          hasBottomLef: false,
          hasBottomRight: false),
      padding: EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(10)),
      child: Column(
        children: [
          Row(
            children: List<Widget>.generate(
                AirdropType.values.length,
                (index) => Expanded(
                    child: _buildTagButton(AirdropType.values[index]))),
          ),
          Expanded(
              child: PageView(
            controller: controller,
            onPageChanged: _onPageChange,
            children: List<Widget>.generate(AirdropType.values.length,
                (index) => _buildPageView(AirdropType.values[index])),
          )),
        ],
      ),
    );
  }

  Widget _buildTagButton(AirdropType type) {
    bool isChoose = type == currentType;
    return GestureDetector(
      onTap: () => onTypePress(type),
      child: Container(
        height: UIDefine.getPixelWidth(55),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(_getTypeName(type),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: AppTextStyle.getBaseStyle(
                        fontSize: UIDefine.fontSize14,
                        fontWeight:
                            isChoose ? FontWeight.w700 : FontWeight.w400,
                        color: isChoose
                            ? const Color(0xFF00FBFB)
                            : const Color(0xFF707070))),
              ),
            ),
            Container(
              height: UIDefine.getPixelWidth(5),
              width: UIDefine.getPixelWidth(20),
              margin: EdgeInsets.only(bottom: UIDefine.getPixelWidth(5)),
              decoration: isChoose
                  ? AppStyle().buildGradient(
                      colors: AppColors.gradientBaseFlipColorBg, radius: 8)
                  : AppStyle()
                      .styleColorsRadiusBackground(color: Colors.transparent),
            )
          ],
        ),
      ),
    );
  }

  String _getTypeName(AirdropType type) {
    switch (type) {
      case AirdropType.dailyReward:
        return tr("dailyRewards");
      case AirdropType.growthReward:
        return tr("growthProcess");
      case AirdropType.soulPath:
        return tr("growthProcess");
    }
  }

  Widget _buildPageView(AirdropType type) {
    switch (type) {
      case AirdropType.dailyReward:
        return const AirdropDailyPage();
      case AirdropType.growthReward:
        return const AirdropGrowthPage();
      case AirdropType.soulPath:
        return const AirdropSoulPage();
    }
  }

  void onTypePress(AirdropType type) {
    setState(() {
      currentType = type;
      controller.jumpToPage(type.index);
    });
  }

  void _onPageChange(int index) {
    setState(() {
      currentType = AirdropType.values[index];
    });
  }
}
