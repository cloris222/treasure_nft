import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:format/format.dart';
import 'package:treasure_nft_project/constant/enum/task_enum.dart';
import 'package:treasure_nft_project/constant/global_data.dart';
import 'package:treasure_nft_project/constant/theme/app_colors.dart';
import 'package:treasure_nft_project/constant/theme/app_image_path.dart';
import 'package:treasure_nft_project/constant/theme/app_style.dart';
import 'package:treasure_nft_project/constant/ui_define.dart';
import 'package:treasure_nft_project/models/http/parameter/level_info_data.dart';
import 'package:treasure_nft_project/utils/app_text_style.dart';
import 'package:treasure_nft_project/utils/number_format_util.dart';
import 'package:treasure_nft_project/view_models/personal/level/level_detail_view_model.dart';
import 'package:treasure_nft_project/views/custom_appbar_view.dart';
import 'package:treasure_nft_project/views/personal/level/level_achievement_page.dart';
import 'package:treasure_nft_project/widgets/app_bottom_navigation_bar.dart';
import 'package:treasure_nft_project/widgets/button/text_button_widget.dart';
import 'package:treasure_nft_project/widgets/gradient_third_text.dart';
import 'package:treasure_nft_project/widgets/label/background_with_land.dart';
import 'package:treasure_nft_project/widgets/label/coin/tether_coin_widget.dart';
import 'package:treasure_nft_project/widgets/label/custom_linear_progress.dart';
import 'package:treasure_nft_project/widgets/label/icon/base_icon_widget.dart';

///MARK: 等級詳細
class LevelDetailPage extends StatefulWidget {
  const LevelDetailPage({Key? key}) : super(key: key);

  @override
  State<LevelDetailPage> createState() => _LevelDetailPageState();
}

class _LevelDetailPageState extends State<LevelDetailPage> {
  late LevelDetailViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = LevelDetailViewModel(setState: setState);
    viewModel.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  EdgeInsetsGeometry mainPadding =
      EdgeInsets.symmetric(horizontal: UIDefine.getPixelWidth(20));

  @override
  Widget build(BuildContext context) {
    return CustomAppbarView(
      needScrollView: false,
      onLanguageChange: () {
        if (mounted) {
          setState(() {});
        }
      },
      type: AppNavigationBarType.typePersonal,
      body: SingleChildScrollView(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Column(children: [
      BackgroundWithLand(
        mainHeight: 230,
        bottomHeight: 100,
        onBackPress: () => viewModel.popPage(context),
        body: Center(child: _buildCurrentLevelStatus()),
      ),
      Container(
          padding: mainPadding,
          color: AppColors.defaultBackgroundSpace,
          child: Column(children: [
            _buildOtherButton(),
            _buildCurrentLevelInfo(),
            // _buildAllLevelBar(),
            _buildAllLevelInfo(),
          ]))
    ]);
  }

  Widget _buildSpace({double height = 4}) {
    return SizedBox(height: UIDefine.getScreenHeight(height));
  }

  ///MARK: 建立現在等級狀態
  Widget _buildCurrentLevelStatus() {
    return Stack(children: [
      SizedBox(
        height: UIDefine.getPixelWidth(180),
        child: Image.asset(
            format(AppImagePath.levelBar,
                ({'level': GlobalData.userInfo.level + 1})),
            fit: BoxFit.fitHeight),
      ),
      Positioned(
          left: UIDefine.getPixelWidth(24),
          top: UIDefine.getPixelWidth(24),
          child: Text('${tr('level')} ${GlobalData.userInfo.level}',
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white))),
      Positioned(
          left: UIDefine.getPixelWidth(24),
          bottom: UIDefine.getPixelWidth(24),
          right: UIDefine.getPixelWidth(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ///MARK: 積分
            Row(children: [
              Text(
                '${tr('lv_point')} : ${GlobalData.userLevelInfo?.point} / ${GlobalData.userLevelInfo?.pointRequired} (${viewModel.getStrPointPercentage()})',
                style: AppTextStyle.getBaseStyle(
                    fontSize: UIDefine.fontSize12, color: Colors.white),
              ),
              Flexible(child: Container()),
            ]),

            ///MARK: 積分條
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: UIDefine.getPixelWidth(8)),
                  child: CustomLinearProgress(
                      height: UIDefine.getPixelWidth(8),
                      percentage: viewModel.getPointPercentage()),
                ),
              ),
              SizedBox(width: UIDefine.getPixelWidth(30)),
              TextButtonWidget(
                  margin: EdgeInsets.only(right: UIDefine.getPixelWidth(20)),
                  btnText: tr('levelUp'),
                  onPressed: () => viewModel.onPressLevelUp(context),
                  backgroundHorizontal: UIDefine.getPixelWidth(15),
                  setSubColor: Colors.transparent,
                  isFillWidth: false,
                  fontWeight: FontWeight.w600,
                  fontSize: UIDefine.fontSize12,
                  setMainColor: Colors.white,
                  radius: 13,
                  isBorderStyle: true)
            ])
          ]))
    ]);
  }

  Widget _buildOtherButton() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: UIDefine.getPixelWidth(10),
          vertical: UIDefine.getPixelWidth(10)),
      margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
      decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
      child: Row(
        children: [
          ///MARK: 每日任務
          Expanded(
            child: InkWell(
                onTap: () {
                  viewModel.pushPage(context,
                      const LevelAchievementPage(initType: TaskType.daily));
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BaseIconWidget(
                          imageAssetPath: AppImagePath.walletLogIcon,
                          size: UIDefine.getPixelWidth(30)),
                      SizedBox(width: UIDefine.getScreenWidth(2)),
                      Text(
                        tr('pt_DAILY'),
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize12,
                            color: AppColors.textBlack),
                      ),
                    ])),
          ),

          ///MARK: 說明
          Expanded(
            child: InkWell(
                onTap: () {
                  viewModel.launchInBrowser(
                      'https://treasurenft.gitbook.io/my-product-docs/faq/instruction-manual/user-levels');
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BaseIconWidget(
                          imageAssetPath: AppImagePath.levelInfoIcon,
                          size: UIDefine.getPixelWidth(30)),
                      SizedBox(width: UIDefine.getScreenWidth(2)),
                      Text(
                        tr('illustrate'),
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize12,
                            color: AppColors.textBlack),
                      ),
                    ])),
          ),

          ///MARK: 成就
          Expanded(
            child: InkWell(
                onTap: () {
                  viewModel.pushPage(context,
                      const LevelAchievementPage(initType: TaskType.achieve));
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BaseIconWidget(
                          imageAssetPath: AppImagePath.trophyIcon,
                          size: UIDefine.getPixelWidth(30)),
                      SizedBox(width: UIDefine.getScreenWidth(2)),
                      Text(
                        tr('achievement'),
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize12,
                            color: AppColors.textBlack),
                      ),
                    ])),
          )
        ],
      ),
    );
  }

  ///MARK: 建立現在等級諮詢
  Widget _buildCurrentLevelInfo() {
    if (viewModel.levelDataList.length > GlobalData.userInfo.level) {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: UIDefine.getPixelWidth(10),
            vertical: UIDefine.getPixelWidth(10)),
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
        decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
        child: Column(children: [
          _buildSingleLevelTitle(GlobalData.userInfo.level),
          _buildSpace(height: 2),
          _buildSingleLevelInfo(GlobalData.userInfo.level),
        ]),
      );
    }
    return Container();
  }

  ///MARK: 建立全部等級資訊
  Widget _buildAllLevelInfo() {
    if (viewModel.levelDataList.isNotEmpty) {
      List<Widget> pages = [];
      for (var data in viewModel.levelDataList) {
        if (data.userLevel != 0) {
          pages.add(_buildLevelPageItem(data.userLevel));
        }
      }
      return Container(
        height: UIDefine.getPixelWidth(650) + UIDefine.navigationBarPadding,
        color: AppColors.defaultBackgroundSpace,
        child: PageView(
            controller: viewModel.pageController,
            children: pages,
            onPageChanged: (index) {
              viewModel.swiperController.move(index);
            }),
      );
    }
    return Container();
  }

  /// 滑動的全部等級bar
  Widget _buildAllLevelBar() {
    if (viewModel.levelDataList.isNotEmpty) {
      List<LevelInfoData> lists = [];
      for (var data in viewModel.levelDataList) {
        if (data.userLevel != 0) {
          lists.add(data);
        }
      }

      return SizedBox(
          height: UIDefine.getPixelHeight(140),
          child: Swiper(
            controller: viewModel.swiperController,
            loop: false,
            viewportFraction:
                UIDefine.getPixelHeight(140) / UIDefine.getWidth(),
            itemCount: lists.length,
            index: viewModel.currentIndex,
            itemBuilder: (context, index) {
              return buildAllLevelBarItem(index, lists[index].userLevel);
            },
            onIndexChanged: (index) {
              viewModel.pageController.jumpToPage(index);
              setState(() {
                viewModel.currentIndex = index;
              });
            },
          ));
    }
    return Container();
  }

  ///MARK: 等級標題
  Widget _buildSingleLevelTitle(int level,
      {bool showLevel = true,
      bool showLock = false,
      bool showBonus = false,
      bool isBlackStyle = true}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Visibility(
        visible: showLock,
        child: BaseIconWidget(
            imageAssetPath: viewModel.checkUnlock(level)
                ? AppImagePath.levelUnLock
                : AppImagePath.levelLock,
            size: UIDefine.getPixelWidth(25)),
      ),
      Visibility(
        visible: showLevel,
        child: Text(' ${tr('level')} $level ',
            style: AppTextStyle.getBaseStyle(
                fontSize:
                    isBlackStyle ? UIDefine.fontSize14 : UIDefine.fontSize16,
                fontWeight: FontWeight.w600,
                color: isBlackStyle ? AppColors.textThreeBlack : Colors.white)),
      ),
      Flexible(child: Container()),
      Visibility(
          visible: viewModel.nextLevel(level) && showBonus,
          child: GestureDetector(
            onTap: () => viewModel.showLeveLBonus(context),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: UIDefine.getPixelWidth(10),
                  vertical: UIDefine.getPixelWidth(5)),
              margin: EdgeInsets.only(bottom: UIDefine.getPixelWidth(10)),
              decoration: AppStyle().buildGradient(
                  colors: AppColors.gradientBackgroundColorBg, radius: 12),
              child: GradientThirdText(
                tr('bonus'),
                size: UIDefine.fontSize12,
              ),
            ),
          ))
    ]);
  }

  ///MARK: 等級詳細
  Widget _buildSingleLevelInfo(int level) {
    LevelInfoData data = viewModel.getSingleLevelInfo(level);

    return Column(children: [
      _buildSingleLevelInfoItem(
          title: tr('reserve_pro_range'),
          context:
              '${NumberFormatUtil().removeTwoPointFormat(data.buyRangeStart)} ~ ${NumberFormatUtil().removeTwoPointFormat(data.buyRangeEnd)}',
          showCoin: true),
      _buildSingleLevelInfoItem(
          title: tr('dialy_reserve'), context: '${data.dailyReverseAmount}'),
      _buildSingleLevelInfoItem(
          title: tr('trade_luk'),
          context: NumberFormatUtil().removeTwoPointFormat(data.couponRate)),
      _buildSingleLevelInfoItem(
          title: tr('directShare-extra'),
          context:
              '${NumberFormatUtil().removeTwoPointFormat(data.directShare)}% & ${NumberFormatUtil().removeTwoPointFormat(data.directSave)}%'),
      _buildSingleLevelInfoItem(
          title: tr('indirectShare-extra'),
          context:
              '${NumberFormatUtil().removeTwoPointFormat(data.indirectShare)}% & ${NumberFormatUtil().removeTwoPointFormat(data.indirectSave)}%'),
      _buildSingleLevelInfoItem(
          title: tr('thirdShare-extra'),
          context:
              '${NumberFormatUtil().removeTwoPointFormat(data.thirdShare)}% & ${NumberFormatUtil().removeTwoPointFormat(data.thirdSave)}%')
    ]);
  }

  Widget _buildSingleLevelInfoItem(
      {required String title, required String context, bool showCoin = false}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: UIDefine.getScreenHeight(1)),
        child: Row(children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.getBaseStyle(
                  fontSize: UIDefine.fontSize12, color: AppColors.textSixBlack),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                  visible: showCoin,
                  child: TetherCoinWidget(size: UIDefine.getPixelWidth(12))),
              SizedBox(width: UIDefine.getScreenWidth(1)),
              Text(context,
                  style: AppTextStyle.getBaseStyle(
                      fontSize: UIDefine.fontSize12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack)),
            ],
          )
        ]));
  }

  Widget buildAllLevelBarItem(int index, int userLevel) {
    bool isCurrent = (index == viewModel.currentIndex);
    return GestureDetector(
      onTap: () {
        viewModel.swiperController.move(index);
      },
      child: Container(
          alignment: Alignment.center,
          height: UIDefine.getPixelWidth(140),
          width: UIDefine.getPixelWidth(140),
          child: isCurrent
              ? Stack(
                  children: [
                    Image.asset(format(AppImagePath.allLevelCurrentBar,
                        {"level": userLevel + 1})),
                    Positioned(
                        bottom: UIDefine.getPixelWidth(20),
                        left: 0,
                        right: 0,
                        child: Text(
                          '${tr('level')} $userLevel',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.getBaseStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: UIDefine.fontSize12,
                              color: Colors.white),
                        ))
                  ],
                )
              : Container(
                  height: UIDefine.getPixelWidth(100),
                  width: UIDefine.getPixelWidth(100),
                  decoration: AppStyle().styleColorsRadiusBackground(
                      color: const Color(0x632E2E2E), radius: 9),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(format(AppImagePath.allLevelBar,
                            {"level": userLevel + 1})),
                      ),
                      Text(
                        '${tr('level')} $userLevel',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.getBaseStyle(
                            fontSize: UIDefine.fontSize12, color: Colors.white),
                      ),
                      SizedBox(height: UIDefine.getPixelWidth(20)),
                    ],
                  ),
                )),
    );
  }

  ///MARK: 等級清單
  Widget _buildLevelPageItem(int level) {
    return Column(children: [
      Container(
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
          child: Stack(
            children: [
              Image.asset(
                format(AppImagePath.allLevelSmailBar, {"level": level + 1}),
                width: UIDefine.getWidth(),
                height: UIDefine.getPixelWidth(120),
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: UIDefine.getPixelWidth(10),
                right: 0,
                child: _buildSingleLevelTitle(level,
                    showLevel: true,
                    showLock: true,
                    showBonus: false,
                    isBlackStyle: false),
              )
            ],
          )),
      Visibility(
        visible: level <= GlobalData.userInfo.level + 1,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: UIDefine.getPixelWidth(10),
              vertical: UIDefine.getPixelWidth(10)),
          margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
          decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
          child: Column(
            children: [
              _buildSingleLevelTitle(level,
                  showLevel: false, showLock: false, showBonus: true),
              _buildSingleLevelInfoRequest(level),
            ],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: UIDefine.getPixelWidth(10),
            vertical: UIDefine.getPixelWidth(10)),
        margin: EdgeInsets.symmetric(vertical: UIDefine.getPixelWidth(10)),
        decoration: AppStyle().styleColorsRadiusBackground(radius: 8),
        child: Column(
          children: [
            _buildSingleLevelTitle(level, showLevel: true, showLock: true),
            _buildSingleLevelInfo(level),
            _buildItemChange(level),
          ],
        ),
      )
    ]);
  }

  ///MARK:升級至下一等級的需求
  Widget _buildSingleLevelInfoRequest(int level) {
    return Container(
        width: UIDefine.getWidth(),
        decoration: AppStyle().styleColorsRadiusBackground(
            color: AppColors.itemBackground, radius: 4),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: level == 1
            ? _buildLevelOneRequest()
            : _buildLevelOtherRequest(level));
  }

  ///MARK:升級至等級1的需求
  Widget _buildLevelOneRequest() {
    return Column(children: [
      _buildSingleRequest(
          level: 1,
          title: tr('depositNFT'),
          value: GlobalData.userLevelInfo!.depositAmount,
          request: GlobalData.userLevelInfo!.depositAmountRequired)
    ]);
  }

  ///MARK:升級至其他等級的需求
  Widget _buildLevelOtherRequest(int level) {
    return Column(children: [
      _buildSingleRequest(
          level: level,
          title: tr('open_A_lv'),
          value: GlobalData.userLevelInfo!.activeDirect,
          request: GlobalData.userLevelInfo!.activeDirectRequired),
      _buildSingleRequest(
          level: level,
          title: tr('open_BC_lv'),
          value: GlobalData.userLevelInfo!.activeIndirect,
          request: GlobalData.userLevelInfo!.activeIndirectRequired)
    ]);
  }

  Widget _buildSingleRequest(
      {required int level,
      required String title,
      required dynamic value,
      required int request}) {
    double percentage = viewModel.checkUnlock(level) ? 1 : value / request;
    return Column(children: [
      Row(children: [
        Expanded(
            child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.getBaseStyle(
              fontSize: UIDefine.fontSize12, color: AppColors.textNineBlack),
        )),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            percentage == 1
                ? tr('Completed')
                : '${NumberFormatUtil().removeTwoPointFormat(value)} / $request',
            style: AppTextStyle.getBaseStyle(
                fontSize: UIDefine.fontSize12, color: AppColors.textNineBlack),
          ),
        ),
      ]),
      _buildSpace(height: 2),
      CustomLinearProgress(percentage: percentage),
      _buildSpace(height: 2),
    ]);
  }

  Widget _buildItemChange(int level) {
    List<Widget> button = [];
    for (var data in viewModel.levelDataList) {
      if (data.userLevel != 0) {
        button.add(_buildCirce(data.userLevel, level));
      }
    }
    return Row(mainAxisSize: MainAxisSize.min, children: button);
  }

  Widget _buildCirce(int level, int currentLevel) {
    bool current = (level == currentLevel);
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onTap: () => viewModel.changePage(level),
          child: CircleAvatar(
              radius: 5,
              backgroundColor:
                  current ? AppColors.textGrey : AppColors.pageUnChoose),
        ));
  }
}
